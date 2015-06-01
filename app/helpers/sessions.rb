helpers do

  def set_facebook_session
    session['facebook-oauth-state'] = SecureRandom.uuid
    @facebook_session = session['facebook-oauth-state']
  end

  def facebook_session?
    @facebook_session
  end

  def current_user
    @user = User.find(session[:user_id]) unless session[:user_id] == nil
  end

  def user_logged_in
    true unless session[:user_id] == nil
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