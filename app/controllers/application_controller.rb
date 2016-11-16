class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Sets the locale, if something other than the default
  # is specified in the URL parameters
  before_action :set_locale

  AUTH_CTX = ADAL::AuthenticationContext.new(
    'login.microsoftonline.com', 'common')
  CLIENT_CRED = ADAL::ClientCredential.new(
    ENV['CLIENT_ID'],
    ENV['CLIENT_SECRET'])
  GRAPH_RESOURCE = 'https://graph.microsoft.com'
  SENDMAIL_ENDPOINT = '/v1.0/me/microsoft.graph.sendmail'
  CONTENT_TYPE = 'application/json;odata.metadata=minimal;odata.streaming=true'

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def acquire_access_token(auth_code, reply_url)
    AUTH_CTX.acquire_token_with_authorization_code(
      auth_code,
      reply_url,
      CLIENT_CRED,
      GRAPH_RESOURCE)
  end

  def auth_hash
    request.env['omniauth.auth']
  end
end

