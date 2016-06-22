require 'httparty'
require_relative './mashed_parser'

module Joinme2
  class Client
    attr_accessor *Configuration::VALID_ACCESSORS

    include HTTParty
    parser Class.new HTTParty::Parser
    parser.send :include, MashedParser

    def initialize(options = {})
      oauth_token = options[:oauth_token]

      options = Joinme2.options.merge(options)
      Configuration::VALID_ACCESSORS.each do |accessor|
        send("#{accessor}=", options[accessor])
      end

      self.class.base_uri base_uri
      @options = {
        headers: {
          "Authorization" => "Bearer #{oauth_token}",
          "Content-Type" => "application/json",
          "User-Agent" => 'X-JOINME-CLIENT'
        }
      }
    end

    # Public: Generates Joinme authorization url based on client_id, auth_uri
    # redirect_uri and scopes. Redirect URI has to match configured Joinme
    # Application callback URL.
    #
    # Examples:
    #
    #   authorize_url(redirect_uri: 'http://example.com/',
    #                 scope: "user_info scheduler start_meeting",
    #                 client_id: "XXXXX")
    #   # =>
    #   "https://secure.join.me/api/public/v1/auth/oauth2..."
    #
    # Returns authorization url as a string.
    def authorize_url(options = {})
      params = {}
      params[:scope] = options[:scope] || default_scopes
      params[:redirect_uri] = options[:redirect_uri] || redirect_uri
      params[:client_id] = options[:client_id] || client_id
      params[:response_type] = options[:response_type] || response_type
      URI.parse(auth_uri).tap do |uri|
        uri.query = URI.encode_www_form params
      end.to_s
    end

    # Public: Connects to Joinme API and starts new meeting.
    #
    # Returns Hashie::Mash representation of API response.
    def start_new_meeting(body = { "startWithPersonalUrl": false })
      payload = @options.dup
      payload[:body] = body.to_json
      self.class.post('/meetings/start', payload)
    end

    def start_sheduled_meeting(id)
      self.class.post("/meetings/#{id}/start", @options)
    end

    def get_scheduled_meeting(id)
      self.class.get("/meetings/#{id}", @options)
    end

    def get_scheduled_meetings(end_date = nil)
      payload = @options.dup
      payload[:headers][:endDate] = end_date if end_date
      self.class.get('/meetings', @options)
    end

    def schedule_new_meeting(name, participants = [], start_date, end_date)
      body = {}
      body[:startWithPersonalUrl] = false
      body[:meetingStart] = iso_date!(start_date)
      body[:meetingEnd] = iso_date!(end_date)
      body[:meetingName] = name
      body[:participants] = participants
      payload = @options.dup
      payload[:body] = body.to_json
      self.class.post('/meetings', payload)
    end

    def update_meeting(id, name = nil, participants = nil, start_date = nil, end_date = nil)
      body = {}
      body[:meetingStart] = iso_date(start_date)
      body[:meetingEnd] = iso_date(end_date)
      body[:meetingName] = name
      body[:participants] = participants
      payload = @options.dup
      payload[:body] = body.to_json
      self.class.patch("/meetings/#{id}", payload)
    end

    def delete_meeting(id)
      self.class.delete("/meetings/#{id}", @options)
    end

    def get_user
      self.class.get('/user', @options)
    end

    private

    def iso_date!(date)
      parse_date(date, true)
    end

    def iso_date(date)
      parse_date(date)
    end

    def parse_date(date, throw_exception = false)
      case
      when date.is_a?(String)
        DateTime.parse(date).iso8601
      when date.is_a?(DateTime)
        date.iso8601
      else
        throw_exception ? (raise BadInputDate) : nil
      end
    end
  end
end
