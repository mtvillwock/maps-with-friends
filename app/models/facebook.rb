class Facebook
  include HTTParty
  base_uri 'https://www.facebook.com'

  def sign_in_url(state)
    p "in facebook#sign_in_url"
    url = "https://www.facebook.com/dialog/oauth?client_id=#{ENV['APP_ID']}&redirect_uri=#{ENV['HOSTNAME']}#{ENV['REDIRECT_URI']}&response_type=code&state=#{state}&scope=user_friends"
    p url
  end

  def request_token(code)
    p code
    p "in request_token"
    response = HTTParty.get("https://graph.facebook.com/v2.3/oauth/access_token?client_id=#{ENV['APP_ID']}&redirect_uri=#{ENV['HOSTNAME'] + ENV['REDIRECT_URI']}&client_secret=#{ENV['APP_SECRET']}&code=#{code}")
  p "response is: "
  p response.parsed_response
  p "user token is: "
  p user_token = response.parsed_response['access_token']
  end

  def inspect_token(user_token, access_token)
    response = HTTParty.get("https://graph.facebook.com/debug_token?input_token=#{user_token}&access_token=#{access_token}")
  p "data hash from inside parsed response is:"
  p data = response.parsed_response["data"]
  p data["app_id"]
  p data["user_id"]
  end

  def refresh_token
    # magic
  end
end
