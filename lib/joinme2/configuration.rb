module Joinme2
  module Configuration
    AUTH_URL = 'https://secure.join.me/api/public/v1/auth/oauth2'
    URL = 'https://api.join.me/v1/'
    API_KEY = 'da6rfunpz6fgyjhfxdm7pqdu'
    REDIRECT_URI = 'https://developer.join.me/io-docs/oauth2callback'
    FORMAT = 'json'
    CLIENT_ID = 'qxbg4y7epnybm3as38j6haf7'
    DEFAULT_SCOPES = 'user_info scheduler start_meeting'

    def self.extended(mod)
      mod.set_defaults
    end

    def set_defaults
      self.base_url = URL
    end
  end
end
