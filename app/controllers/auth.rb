get '/login_with_facebook' do

end

get '/auth/:provider/callback' do
  response = HTTParty.new("https://www.facebook.com/dialog/oauth?
    client_id=#{ENV['APP_ID']}&display=popup&
    response_type=token&
   &redirect_uri=#{ENV['REDIRECT-URI']}")
#https://www.facebook.com/connect/login_success.html#access_token=ACCESS_TOKEN
end

#exchange code for access token
get '/exchange_code_for_token' do
  response = HTTParty.new("https://graph.facebook.com/v2.3/oauth/access_token?
    client_id=#{ENV['APP_ID']}
   &redirect_uri=#{ENV['REDIRECT-URI']}
   &client_secret=#{ENV['APP_SECRET']}
   &code={code-parameter}")
end
# response will be JSON, and will be an access token or an error message


#https://developers.facebook.com/docs/facebook-login/manually-build-a-login-flow/v2.3#checktoken
get 'inspect_access_token' do
  # response = HTTParty.new("graph.facebook.com/debug_token?
  #      input_token={token-to-inspect}
  #      &access_token={app-token-or-admin-token}")
# Returns JSON containing data about inspected token
end

# Store token in Database
# Need to track login status
# Need to log people out