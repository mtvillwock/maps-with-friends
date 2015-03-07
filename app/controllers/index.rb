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