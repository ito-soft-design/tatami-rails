class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_domain

  before_filter :set_locale

=begin
  before_filter :password_protected if Rails.env.production?

  protected

  def password_protected
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end
=end

  def default_url_options(options={})
    { :locale => I18n.locale }
  end

  def set_locale
    if params[:locale].nil?
      logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
      I18n.locale = extract_locale_from_accept_language_header
      logger.debug "* Locale set to '#{I18n.locale}'"
    else
      I18n.locale = params[:locale]
    end
  end

  private
  
  def extract_locale_from_accept_language_header
    if request.env['HTTP_ACCEPT_LANGUAGE']
      request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    else
      "ja"
    end
  end

  def get_domain
    $http_host = request.env['HTTP_HOST']
    $http_schema = request.env['rack.url_scheme']
    $server_domain = request.domain
    $server_port = request.port
  end
  
end
