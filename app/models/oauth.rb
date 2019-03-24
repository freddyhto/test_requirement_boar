class Oauth
  #URLs to google oauth API
  AUTHORIZATION_REQUEST_API_URL = "https://accounts.google.com/o/oauth2/auth"
  AUTHORIZATION_GRANT_URL = 'https://accounts.google.com/o/oauth2/token'
  USER_INFO_URL = 'https://www.googleapis.com/oauth2/v2/userinfo'

  CONFIG_FILE = "#{Rails.root}/config/googleOauth.json"
  #redirect to google for authorization request of resource owner
  class << self
    def authorization_request_url
      url = URI(AUTHORIZATION_REQUEST_API_URL)
      url.query = authorization_params.to_param
      url.to_s
    end

    def authorization_params
      {client_id: client_id,
       redirect_uri: TEST_REQUEST_BOARD_APP_URL,
       response_type: 'code',
       scope: "profile,email",  
       access_type: 'offline',
       }
    end

    def config_file
      file = File.open(CONFIG_FILE).read
      JSON.parse file
    end

    def client_id
      config_file['web']['client_id']
    end

    #handle the request to get the access token
    def authorization_grant_request code
      HTTParty.post(AUTHORIZATION_GRANT_URL, body: authorization_grant_params(code)).parsed_response
    end

    def authorization_grant_params code
      {code: code,
       client_id: clinet_id,
       client_secret: config_file['web']['client_secret'],
       redirect_uri: callback_oauth_url,
       grant_type: 'authorization_code'}
    end

    def get_user_info access_token
      HTTParty.post(USER_INFO_URL, headers: {'Authorization: Bearer' => access_token}).parsed_response
    end

  end
end
