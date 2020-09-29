# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Chatrooms", type: :request do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  it "creates a chatroom" do
    new_name = "Ruby"
    post "/chatroom", params: {
      chatroom: { name: new_name, language: "javascritpt" }
    }
    expect(response).to have_http_status(:found)
    expect(Chatroom.last.name).to eq("Ruby")
  end

  it "shows a chatroom" do
    new_name = "Ruby"
    post "/chatroom", params: {
      chatroom: { name: new_name, language: "javascritpt" }
    }
    expect(response).to redirect_to(assigns(:chatroom))
    follow_redirect!
    expect(response).to render_template(:show)
  end
end
