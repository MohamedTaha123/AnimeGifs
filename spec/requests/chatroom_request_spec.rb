# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Chatrooms', type: :request do
  
  it 'create a chatroom and redirect to chatroom page' do
    get 'chatroom/new'
    expect(response).to render_template(:new)
    post '/chatroom', params: { chatroom: { name: 'Ruby', language: 'Ruby' } }
    expect(response).to render_template(:show)
    expect(response.body).to  include('Room Created')
  end
end
