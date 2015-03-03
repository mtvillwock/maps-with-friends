get '/' do


  erb :index
end

post '/' do
  @user = User.new(name: params[:name], location: params[:location])
  content_type :json
  if @user.save
    p @user
    p "user saved"
    {name: @user.name, location: @user.location}.to_json
  else
    {error: "User did not save"}.to_json
  end
end
