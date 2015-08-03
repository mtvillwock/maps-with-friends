# =========================
# Register
# =========================
get '/register' do
  erb :register
end

post '/register' do
  user = User.new(
    email: params[:user][:email],
    password_hash: params[:user][:password]
    )
  p params
  if user.save!
    set_session(user)
    # session[:user_id] = user.id
    redirect '/'
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
# Logout (Email/Password)
# =========================
delete '/logout' do
  p "in delete route, session is:"
  p session[:user_id]
  session[:user_id] = nil
  p "logged out, session is "
  p session[:user_id]
  redirect '/'
end