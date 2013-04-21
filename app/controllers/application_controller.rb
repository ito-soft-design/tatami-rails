class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_domain

=begin
  before_filter :password_protected if Rails.env.production?

  protected

  def password_protected
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end
=end

  private
  
  def get_domain
    $http_host = request.env['HTTP_HOST']
    $http_schema = request.env['rack.url_scheme']
    $server_domain = request.domain
    $server_port = request.port
  end
  
end
