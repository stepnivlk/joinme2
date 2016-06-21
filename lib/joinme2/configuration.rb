module Joinme2
  module Configuration
    AUTH_URI = 'https://secure.join.me/api/public/v1/auth/oauth2'.freeze
    BASE_URI = 'https://api.join.me/v1/'.freeze
    API_KEY = nil
    REDIRECT_URI = nil
    CLIENT_ID = nil
    DEFAULT_SCOPES = 'user_info scheduler start_meeting'.freeze

    VALID_ACCESSORS = [:base_uri,
                       :default_scopes,
                       :redirect_uri,
                       :client_id,
                       :auth_uri].freeze

    attr_accessor *VALID_ACCESSORS

    def configure
      yield self
    end

    def options
      VALID_ACCESSORS.inject({}) do |accessor, key|
        accessor.merge!(key => send(key))
      end
    end

    def self.extended(mod)
      mod.set_defaults
    end

    def set_defaults
      self.base_uri = BASE_URI
      self.default_scopes = DEFAULT_SCOPES
      self.redirect_uri = REDIRECT_URI
      self.client_id = CLIENT_ID
      self.auth_uri = AUTH_URI
    end
  end
end
