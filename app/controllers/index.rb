# =========================
# Index
# =========================
get '/' do

  erb :index
end

# =========================
# Make a Friend Marker
# =========================
post '/' do
  @friend = Friend.new(name: params[:name], location: params[:location])
  content_type :json
  if @friend.save
    p @friend
    p "friend saved"
    {name: @friend.name, location: @friend.location}.to_json
  else
    {error: "Friend did not save"}.to_json
  end
end


# =========================
# Populate Map from User's friends
# =========================
get '/locations' do
  @user = current_user
  @friends = User.friends
  friends_and_locations = []
  content_type :json
  @friends.each do |friend, location|
    friend = {name: friend.name, city: friend.location}
    friends_and_locations << friend
  end
  friends_and_locations.to_json
end

# =========================
# Register
# =========================
get '/register' do

  erb :register
end

post '/register' do
  content_type :json
  # AJAX switch login to sign-in
  user = User.new(params[:user])
    if user.save
      {welcome: "Greetings, #{user.username}"}.to_json
      redirect '/login'
    else
      {error: "Something went wrong."}.to_json
      erb :register
    end
end

# =========================
# Login
# =========================
get '/login' do

  erb :login
end

post '/login' do
  # AJAX sign-in
  p params
  @user = User.find_by(email: params[:email])
  p @user
  p @user.password
  if @user && @user.password == params[:password]
    session[:user_id] = @user.id
    p session[:user_id]
    redirect '/'
  else
    erb :login
  end
end

# =========================
# Logout
# =========================
delete '/logout' do
  # AJAX sign out (or just send home?)
  session[:user_id] = nil
  redirect '/'
end