require './cheez_api'

cheez_api = CheezApi.new

get '/' do
	if session[:oauth_access_token].nil?
		redirect '/login'
	else
		redirect '/whoami'
	end
end

get '/login' do
  redirect cheez_api.getAuthorizationUrl;
end

get '/cheezburger_login' do 
	session[:oauth_access_token] = cheez_api.authenticate params['code']
	redirect '/'
end

get '/whoami' do
	me = cheez_api.whoami session[:oauth_access_token]
	"<h2>#{me['username']}</h2>" +
	"<p>#{me['first_name']} #{me['last_name']}</p>" +
	"<img src='#{me['avatar_url']}'>"
end