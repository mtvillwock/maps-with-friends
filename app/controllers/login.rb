# =========================
# Register
# =========================
get '/register' do

  erb :register
end

post '/register' do
  user = User.new(
    username: params[:user][:username],
    email: params[:user][:email],
    password_hash: params[:user][:password]
    )
  p params
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
  session[:user_id] = nil
  redirect '/'
end