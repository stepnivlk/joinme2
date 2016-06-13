# require "joinme2/version"
require File.expand_path('../joinme2/configuration', __FILE__)
require File.expand_path('../joinme2/client', __FILE__)

module Joinme2

  def self.client(oauth_token, options = {})
    Joinme2::Client.new(oauth_token, options)
  end

  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)
    client.send(method, *args, &block)
  end

  def self.respond_to?(method, include_all=false)
    return client.respond_to?(method.to_sym, include_all) || super
  end

  def self.authorize_url(client_id = nil, options = {})
    params = {}
    params[:scope] = options[:scope] || Configuration::DEFAULT_SCOPES
    params[:redirect_uri] = options[:redirect_uri] || Configuration::REDIRECT_URI
    params[:client_id] = client_id || Configuration::CLIENT_ID
    URI.parse(Configuration::AUTH_URL).tap do |uri|
      uri.query = URI.encode_www_form params
    end.to_s
  end
end
