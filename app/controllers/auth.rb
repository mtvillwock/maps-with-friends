require 'json'
require 'httparty'

get '/login-via-facebook' do
#   facebook = Facebook.new
#   state = set_facebook_session
#   p "FB OAuth State in session hash is: #{state}"
  # redirect facebook.sign_in_url(state)
  redirect '/auth/facebook'
end

get '/auth/facebook/callback' do
  puts "auth hash from omniauth is: \n\n #{auth_hash}"
  user = User.new
  @user = user.from_omniauth(auth_hash)
  p @user
  session[:user_id] = @user.id
  p "post OAuth, session is #{session[:user_id]}"
  redirect '/'
end

post '/logout-of-facebook' do
  app_url = "https://maps-with-friends.herokuapp.com/"
  access_token = ENV['APP_ID'] + "%7C" + ENV['APP_SECRET']
  Httparty.post("https://www.facebook.com/logout.php?next=#{app_url}&access_token=#{access_token}")
end

# get '/oauth2callback' do
#   facebook = Facebook.new
#   p state = params["state"]
#   p code = params["code"]
#   p facebook_session?

#   # if state == session['facebook-oauth-state']
#   # EXCHANGE CODE FOR ACCESS TOKEN
#   user_token = facebook.request_token(code)
#   # The %&C is necessary to escape the | character in the access token that uses the app id and secret
#   p access_token = ENV['APP_ID'] + "%7C" + ENV['APP_SECRET']
#   # INSPECT ACCESS TOKEN
#   inspected_token = facebook.inspect_token(user_token, access_token)
#   auth_info = facebook.get_user_info(user_token)
#   p "User info from Facebook is: \n\n#{auth_info}"
#   user = User.new
#   # CREATE OR LOGIN USER
#   user.from_omniauth(auth_info)
#   # See user.rb for methods Rafael wrote
#   # formatting is different because I think
#   # he used the omniauth gem, but I can
#   # switch over to that if it is easier
#   # update oauth_token, uid, email, location
#   # redirect home or throw error
#   redirect '/'

#   # Use this reference for FB OAuth and for how to write a good README
#   # https://github.com/TeaWithStrangers/tws-on-rails
# end

#   # Store token in Database
#   # Need to track login status
#   # Need to log people out