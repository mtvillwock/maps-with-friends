require 'json'
require 'httparty'

get '/login-via-facebook' do
  facebook = Facebook.new
  session['facebook-oauth-state'] = SecureRandom.uuid
  state = session['facebook-oauth-state']
  p "FB OAuth State in session hash is: #{state}"
  redirect facebook.sign_in_url(state)
end

get '/oauth2callback' do
  facebook = Facebook.new
  p state = params["state"]
  p code = params["code"]
  session["foo"] = "bar"
  p "session hash is:"
  p session
  p session['facebook-oauth-state']

  # if state == session['facebook-oauth-state']
  # EXCHANGE CODE FOR ACCESS TOKEN
  user_token = facebook.request_token(code)
  # The %&C is necessary to escape the | character in the access token that uses the app id and secret
  p access_token = ENV['APP_ID'] + "%7C" + ENV['APP_SECRET']
  # INSPECT ACCESS TOKEN
  facebook.inspect_token(user_token, access_token)
  # CREATE OR LOGIN USER
  p "you made it"
end

  # Store token in Database
  # Need to track login status
  # Need to log people out