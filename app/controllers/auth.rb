require 'json'
require 'httparty'
# Routes for Facebook OAuth
get '/login-via-facebook' do
  p "hit the route"
# end

# CONTACTING FACEBOOK TO OPEN DIALOG
# get '/auth/:provider/callback' do
response = HTTParty.get("https://www.facebook.com/dialog/oauth?
  client_id=#{ENV['APP_ID']}&display=popup&
  response_type=code&
  &redirect_uri=#{ENV['REDIRECT_URI']}")
p response
p params
state = params["state"]
code = params["code"]
  # code response type returns an encrypted string, use this type for server handling access token

#https://www.facebook.com/connect/login_success.html#access_token=ACCESS_TOKEN
# end

# EXCHANGE CODE FOR ACCESS TOKEN
# get '/exchange_code_for_token' do
response = HTTParty.post("https://graph.facebook.com/v2.3/oauth/access_token?
  client_id=#{ENV['APP_ID']}
  &redirect_uri=#{ENV['REDIRECT-URI']}
  &client_secret=#{ENV['APP_SECRET']}
  &code={code-parameter}")
# end
# response will be JSON, and will be an access token or an error message
# {“access_token”: <access-token>, “token_type”:<type>, “expires_in”:<seconds-til-expiration>}


#https://developers.facebook.com/docs/facebook-login/manually-build-a-login-flow/v2.3#checktoken
# INSPECT ACCESS TOKEN
# get 'inspect_access_token' do
  # response = HTTParty.new("graph.facebook.com/debug_token?
  #      input_token={token-to-inspect}
  #      &access_token={app-token-or-admin-token}")
# Returns JSON containing data about inspected token
# Check if the user id, app id, and application are valid
# Sample JSON response
# {
#     "data": {
#         "app_id": 138483919580948,
#         "application": "Social Cafe",
#         "expires_at": 1352419328,
#         "is_valid": true,
#         "issued_at": 1347235328,
#         "metadata": {
#             "sso": "iphone-safari"
#         },
#         "scopes": [
#             "email",
#             "publish_actions"
#         ],
#         "user_id": 1207059
#     }
# }
end

# Store token in Database
# Need to track login status
# Need to log people out