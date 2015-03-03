get '/' do


  erb :index
end

post '/' do
  @user = User.new(name: params[:name], location: params[:location])
  p @user
  p "executed user.new"
  if @user.save
    p @user
    p "user saved"
    content_type :json
    {name: @user.name, location: @user.location}.to_json
  else
    {error: "User did not save"}.to_json
  end
end
