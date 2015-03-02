require 'spec_helper'

describe "index controller" do
	it "should return a 200 status" do
		get '/'
		expect(last_response).to be_ok
	end
end