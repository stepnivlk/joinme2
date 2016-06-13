require 'httparty'

module Joinme2
  class Client
    attr_accessor :base_url

    include HTTParty

    def initialize(oauth_token, options = {})
      self.class.base_uri "https://api.join.me/v1"
      @options = {
        headers: {
          "Authorization" => "Bearer #{oauth_token}",
          "Content-Type" => "application/json",
          "User-Agent" => 'X-JOINME-CLIENT'
        }
      }
    end

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
      self.class.get('/meetings', payload)
    end

    def schedule_new_meeting(start_date, end_date, name, participants = [])
      body = {}
      body[:meetingStart] = DateTime.parse(start_date).iso8601
      body[:meetingEnd] = DateTime.parse(end_date).iso8601
      body[:meetingName] = name
      body[:participants] = participants
      payload = @options.dup
      payload[:body] = body.to_json
      self.class.post('/meetings', payload)
    end

    def update_meeting(id, start_date = nil, end_date = nil, name = nil, participants = nil)
      body = {}
      body[:meetingStart] = DateTime.parse(start_date).iso8601 if start_date
      body[:meetingEnd] = DateTime.parse(end_date).iso8601 if end_date
      body[:meetingName] = name if name
      body[:participants] = participants if participants
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
  end
end
