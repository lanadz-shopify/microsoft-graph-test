###
#  Copyright (c) Microsoft. All rights reserved. Licensed under the MIT license.
#  See LICENSE in the project root for license information.
##
class PagesController < ApplicationController
  skip_before_action :verify_authenticity_token
  def login
    redirect_to '/auth/azureactivedirectory'
  end

  def callback
    # Authentication redirects here
    code = params[:code]

    # Used in the template
    @name = auth_hash.info.name
    @email = auth_hash.info.email

    # Request an access token
    result = acquire_access_token(code, ENV['REPLY_URL'])

    # Associate token/user values to the session
    session[:access_token] = result.access_token
    session[:name] = @name
    session[:email] = @email

    # Debug logging
    logger.info "Code: #{code}"
    logger.info "Name: #{@name}"
    logger.info "Email: #{@email}"
    logger.info "[callback] - Access token: #{session[:access_token]}"
  end

  def send_mail
    logger.debug "[send_mail] - Access token: #{session[:access_token]}"

    # Used in the template
    @name = session[:name]
    @email = params[:specified_email]
    @recipient = params[:specified_email]
    @mail_sent = false

    send_mail_endpoint = URI("#{GRAPH_RESOURCE}#{SENDMAIL_ENDPOINT}")
    content_type = CONTENT_TYPE
    http = Net::HTTP.new(send_mail_endpoint.host, send_mail_endpoint.port)
    http.use_ssl = true

    email_body = File.read('app/assets/MailTemplate.html')
    email_body.sub! '{given_name}', @name
    email_subject = t('email_subject')

    logger.debug email_body

    email_message = "{
            Message: {
            Subject: '#{email_subject}',
            Body: {
                ContentType: 'HTML',
                Content: '#{email_body}'
            },
            ToRecipients: [
                {
                    EmailAddress: {
                        Address: '#{@recipient}'
                    }
                }
            ]
            },
            SaveToSentItems: true
            }"

    response = http.post(
      SENDMAIL_ENDPOINT,
      email_message,
      'Authorization' => "Bearer #{session[:access_token]}",
      'Content-Type' => content_type
    )

    logger.debug "Code: #{response.code}"
    logger.debug "Message: #{response.message}"

    # The send mail endpoint returns a 202 - Accepted code on success
    if response.code == '202'
      @mail_sent = true
    else
      @mail_sent = false
      flash[:httpError] = "#{response.code} - #{response.message}"
    end

    render 'callback'
  end
  # rubocop:enable Metrics/AbcSize

  # Deletes the local session and sends the browser to the logout endpoint
  # so Azure AD has a chance to handle its own logout flow
  # After Azure AD is done, it redirects the browser to the value in
  # post_logout_redirect_uri, which happens to be our start screen
  def disconnect
    reset_session
    redirect = "#{ENV['LOGOUT_ENDPOINT']}"\
               "?post_logout_redirect_uri=#{ERB::Util.url_encode(root_url)}"
    logger.info 'REDIRECT: ' + redirect
    redirect_to redirect
  end
end
