# =========================
# Index
# =========================
get '/test' do
  erb :test
end

get '/' do
  facebook = Facebook.new
  @facebook_url = facebook.sign_in_url
  @user = User.find_or_initialize_by(id: session[:user_id])
  @friends = []
  @user.friendships.each do |friendship|
    @friends << Friend.find(friendship.friend_id)
  end
  erb :index
end

# =========================
# Make a User / Friendship
# =========================
post '/' do
  @user = User.find_by(id: session[:user_id])
  p "current user is: "
  p @user
  @friend = User.find_or_initialize_by(name: params[:name])
  p "new friend is: "
  @friend.update_attributes(location: params[:location])
  p @friend
  if @friend.location != nil
    content_type :json
    if @friend.save
      @friendship = Friendship.create(friend_id: @friend.id, user_id: current_user.id)
      p @friendship
      {name: @friend.name, location: @friend.location, id: @friend.id}.to_json
    else
      {error: "Friend did not save"}.to_json
    end
  end
end

# =========================
# Delete a Friend and Friendship
# =========================

# delete '/friends/:id/delete' do
#   @friend = Friend.find(params[:id])
#   content_type :json
#   if @friend.delete
#     { id: params[:id] }.to_json
#   else
#     { error: "Friend not destroyed"}.to_json
#   end
# end

# =========================
# Populate Map from User's friends
# =========================
get '/locations' do
  @user = User.find_by(id: session[:user_id])
  @friendships = @user.friendships
  p "friendships: "
  p @friendships
  @friends = []
  if !@friendships.empty?
    # @friendships.each do |friendship|
      @friends << User.find_by(id: friendship.friend_id).name
  #   end
  #   p @friends.each { |f| f.name }
    content_type :json
  #   # @friends.each do |friend|
  #   #   friend = {name: friend.name, location: friend.location}
  #   #   friends_and_locations << friend
  #   # end
  #   # friends_and_locations.to_json
  #   if @friends
      @friends.to_json
    # end
  else
    content_type :json
    {error: "No friendships found"}.to_json
  end
end