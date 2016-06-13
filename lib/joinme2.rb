# require "joinme2/version"
require File.expand_path('../joinme2/configuration', __FILE__)
require File.expand_path('../joinme2/client', __FILE__)

module Joinme2
  extend Configuration

  def self.client(options = {})
    Joinme2::Client.new(options)
  end

  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)
    client.send(method, *args, &block)
  end

  def self.respond_to?(method, include_all=false)
    return client.respond_to?(method, include_all) || super
  end
end
