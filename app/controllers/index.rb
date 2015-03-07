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
  p '*' * 80
  p current_user
  p current_user.id
  @friend = Friend.new(name: params[:name], location: params[:location])
  content_type :json
  if @friend.save
    @friend.update_attributes(user_id: current_user.id)
    p '*' * 80
    {name: @friend.name, location: @friend.location}.to_json
  else
    {error: "Friend did not save"}.to_json
  end
end


# =========================
# Populate Map from User's friends
# =========================
get '/locations' do
  p current_user
  @user = User.find_by(id: session[:user_id])
  p "THIS GUY" * 30
  p @user
  @friends = @user.friends
  p @friends
  friends_and_locations = []
  content_type :json
  @friends.each do |friend, location|
    p friend = {name: friend.name, location: friend.location}
    friends_and_locations << friend
  end
  p "ALL MY FRIENDS" * 20
  p friends_and_locations
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
      redirect '/login'
    else
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
  @user = User.find_by(email: params[:user][:email])
  if @user && @user.password == params[:user][:password]
    session[:user_id] = @user.id
    redirect '/'
  else
    erb :login
  end
end

# =========================
# Logout
# =========================
delete '/logout' do
  p "begin logout"
  p session
  session[:user_id] = nil
  p "should be nil now"
  p session
  redirect '/'
end