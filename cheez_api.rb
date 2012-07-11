require 'httparty'

class CheezApi
	
	def initialize
		@client_id = '96105f5732fc78466af2fef33a9d2662'
		@client_secret = '2cb2d210779a7aa76bbccc1bfeb2b5c0'

		@url = 'https://api.cheezburger.com/'
		@auth = @url + 'oauth/'
		@api = @url + 'v1/'
	end

	def getAuthorizationUrl
 		"#{@auth}authorize?response_type=code&client_id=#{@client_id}&redirect_uri=http://localhost:3000/cheezburger_login"
	end

	def authenticate(code)
		url = @auth + 'access_token'
		options = { 
					client_id: @client_id, 
					client_secret: @client_secret, 
					code: code, 
					grant_type: 'authorization_code'
				  }
		response = HTTParty::post url, body: options
		response.parsed_response['access_token']
	end

	def whoami(access_token)
		url = @api + "me?access_token=#{access_token}"
		response = HTTParty::get url
		response.parsed_response['items'].first
	end
end