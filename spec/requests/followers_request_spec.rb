require 'rails_helper'

RSpec.describe "Followers", type: :request do

  describe "GET /follow" do
    it "returns http success" do
      get "/followers/follow"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /unfollow" do
    it "returns http success" do
      get "/followers/unfollow"
      expect(response).to have_http_status(:success)
    end
  end

end
