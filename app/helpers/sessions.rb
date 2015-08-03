helpers do
  def auth_hash
    request.env['omniauth.auth']
  end

  def set_facebook_session
    session['facebook-oauth-state'] = SecureRandom.uuid
    @facebook_session = session['facebook-oauth-state']
  end

  def facebook_session?
    @facebook_session
  end

  def current_session
    session[:user_id]
  end

  def set_session(user)
    session[:user_id] = user.id
  end

  def current_user
    @user = User.find_by(id: session[:user_id])
    if @user.nil?
      p "no user"
      false
    else
      p "Current user is #{@user}"
      @user
    end
  end

  def user_logged_in
    current_user
  end

  def get_facebook_app_id
    ENV['APP_ID']
  end

  def get_facebook_app_secret
    ENV['APP_SECRET']
  end

  def get_facebook_client_token
    ENV['CLIENT_TOKEN']
  end

  def get_redirect_uri
    ENV['REDIRECT_URI']
  end

  def get_hostname
    ENV['HOSTNAME']
  end

end
