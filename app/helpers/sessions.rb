helpers do

  def current_user
    @user = User.find(session[:user_id]) unless session[:user_id] == nil
  end

  def user_logged_in
    true unless session[:user_id] == nil
  end

end