class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  # AUTH_CTX = ADAL::AuthenticationContext.new(
  #   'login.microsoftonline.com', 'common')
  # CLIENT_CRED = ADAL::ClientCredential.new(
  #   ENV['CLIENT_ID'],
  #   ENV['CLIENT_SECRET'])
  GRAPH_RESOURCE = 'https://graph.microsoft.com'
  USERS_ENDPOINT = '/v1.0/users'

  def index
    logger.debug "[listing contacts] - Access token: #{session[:access_token]}"

    # Used in the template
    @name = session[:name]

    users_endpoint = URI("#{GRAPH_RESOURCE}#{USERS_ENDPOINT}")
    content_type = CONTENT_TYPE

    http = Net::HTTP.new(users_endpoint.host, users_endpoint.port)
    http.use_ssl = true


    @response = http.get(
      USERS_ENDPOINT,
      'Authorization' => session[:access_token],
      'Content-Type' => content_type
    )

  end
end
