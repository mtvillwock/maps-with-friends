require 'spec_helper'

describe "index controller" do
  context "GET /" do
  	it "should return a 200 status" do
  		get '/'
  		expect(last_response).to be_ok
  	end
    it "should find or initialize a user with session id" do
      # see above
    end
    it "should create an array of friends based on the user's friendships" do
      # User > Friendships > Friends
    end
    it "should render the index page file" do
      # render erb: index
    end
  end
  context 'POST /' do

    it 'should initialize or find a friend/user' do
      # Find or initialize a new friend to DB,
    end
    it "should update the friend/user's location attribute" do
      # test update attributes for location
    end
    it "should save the friend/user if it has a location that isn't nil" do
      #save if friend has location
    end
    it "should return an error if the friend does not save" do
      # expect JSON error message returned
    end
  end
  context 'GET /locations' do
  #Fetch all friends from DB, return JSON of Users/friends
    it "should find user by session id" do
      # see above
    end
    it "should find an array of User friendships" do
      # test User.friendships
    end
    it "should return a collection of friends as JSON" do
      # exactly what it sounds like
    end
    it "should return a JSON error if no friendships are found" do
      # see above
    end
  end
end