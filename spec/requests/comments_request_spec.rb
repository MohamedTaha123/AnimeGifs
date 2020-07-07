require 'rails_helper'

RSpec.describe "Comments", type: :request do
    let(:user) { create(:user) }
    let(:gif) { create(:gif, user_id: user.id)}
    let(:comment) { create( :comment, commentable: gif, user_id: user.id)}
    before do
      sign_in user
    end
    it 'should create new comment ' do
        new_comment = 'hey there im test'
       
        post "/gifs/#{gif.label}/comments", params: {
            comment: { body: new_comment, commentable: :gif }
        }
        expect(response).to have_http_status(:found)
        expect(Comment.last.body).to  eq(new_comment)
    end
    it 'should create a comment for comment' do
        new_comment = "hey there, im a comment test"
        
        post "/comments/#{comment.id}/comments", params: {
            comment: { body: new_comment, commentable: :comment }
        }
        expect(response).to have_http_status(:found)
        expect(Comment.last.body).to  eq(new_comment)

    end
end
