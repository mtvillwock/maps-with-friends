get '/' do

  erb :index
end

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


# AJAX call to populate map
get '/locations' do
  @friends = Friend.all
  friends_and_locations = []
  content_type :json
  @friends.each do |friend, location|
    friend = {name: friend.name, city: friend.location}
    friends_and_locations << friend
  end
  friends_and_locations.to_json
end

post '/register' do
  content_type :json
  # AJAX switch login to sign-in
  user = User.new(params[:user])
    if user.save
      {welcome: "Greetings, #{user.username}"}.to_json
    else
      {error: "Something went wrong."}.to_json
    end
end

post '/login' do
  content_type :json
  # AJAX sign-in
  @user = User.find_by(email: params[:email])
  if @user && @user.password == params[:password]
    session[:user_id] = @user.id
  else
    {error: "Incorrect password"}.to_json
  end
end

delete '/logout' do
  # AJAX sign out (or just send home?)
  session[:user_id] = nil
end