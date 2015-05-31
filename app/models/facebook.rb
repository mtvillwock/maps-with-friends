class Facebook
  include HTTParty
  base_uri 'https://www.facebook.com'

  def sign_in_url
    p "in sign_in"
    # url string with the client key and redirect url (your hostname + oauth2callback) and whatever scope or other parameters you need
    url = "https://www.facebook.com/dialog/oauth?client_id=#{ENV['APP_ID']}&response_type=code&redirect_uri=#{ENV['HOSTNAME']}#{ENV['REDIRECT_URI']}"
    p url
    url
    #https://accounts.google.com/o/oauth2/auth?
    # scope=email%20profile&
    # state=security_token%3D138r5719ru3e1%26url%3Dhttps://oa2cb.example.com/myHome&
    # redirect_uri=https%3A%2F%2Foauth2-login-demo.appspot.com%2Fcode&,
    # response_type=code&
    # client_id=812741506391.apps.googleusercontent.com&
    # approval_prompt=force
  end

  def request_token(code)
    p code
    p "in request_token"
    # self.post(“/oauth2/v3/token,
    #   body: {
    #     client_id: CLIENT_KEY,
    #     client_secret: CLIENT_SECRET,
    #     redirect_url: “http://localhost:3000/whatever”,
    #             grant_type: “authorization_code”, # vs token, which is longer duration
    #             code: code # this is passed in from when you request the code initially
    #           }
  end

  def refresh_token
    # magic
  end
end
