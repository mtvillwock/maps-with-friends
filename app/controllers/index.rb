get '/' do


  erb :index
end

post '/' do
  @user = User.new(name: params[:name], location: params[:location])
  content_type :json
  {name: @user.name, location: @user.location}.to_json
end
