require 'json'
require 'httparty'

get '/login-via-facebook' do
  facebook = Facebook.new
  state = set_facebook_session
  p "FB OAuth State in session hash is: #{state}"
  redirect facebook.sign_in_url(state)
end

get '/oauth2callback' do
  facebook = Facebook.new
  p state = params["state"]
  p code = params["code"]
  p facebook_session?

  # if state == session['facebook-oauth-state']
  # EXCHANGE CODE FOR ACCESS TOKEN
  user_token = facebook.request_token(code)
  # The %&C is necessary to escape the | character in the access token that uses the app id and secret
  p access_token = ENV['APP_ID'] + "%7C" + ENV['APP_SECRET']
  # INSPECT ACCESS TOKEN
  inspected_token = facebook.inspect_token(user_token, access_token)
  # CREATE OR LOGIN USER
  p info = facebook.get_user_info(user_token)
  p "#{info}"
  # user = User.new
  # user.from_omniauth(auth)
  # See user.rb for methods Rafael wrote
  # formatting is different because I think
  # he used the omniauth gem, but I can
  # switch over to that if it is easier
  # update oauth_token, uid, email, location
  # redirect home or throw error
  # redirect '/'

  # Use this reference for FB OAuth and for how to write a good README
  # https://github.com/TeaWithStrangers/tws-on-rails
end

  # Store token in Database
  # Need to track login status
  # Need to log people out