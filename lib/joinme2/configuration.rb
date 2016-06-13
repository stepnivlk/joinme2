module Joinme2
  module Configuration
    AUTH_URL = 'https://secure.join.me/api/public/v1/auth/oauth2'
    URL = 'https://api.join.me/v1/'
    API_KEY = ''
    REDIRECT_URI = ''
    FORMAT = 'json'
    CLIENT_ID = ''
    DEFAULT_SCOPES = 'user_info scheduler start_meeting'

    def self.extended(mod)
      mod.set_defaults
    end

    def set_defaults
      self.base_url = URL
    end
  end
end
