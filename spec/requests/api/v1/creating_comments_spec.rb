require 'rails_helper'

RSpec.describe 'Creating comments' do
  let(:user) { FactoryBot.create(:user) }
  let(:recipe) { FactoryBot.create(:recipe, user: user) }
  let(:headers) { valid_headers }

  describe 'POST /api/v1/comments' do
    context 'with valid body and attributes' do
      before { post '/api/v1/comments', params: {user_id: user.id, recipe_id: recipe.id, body: 'New comment'}.to_json, headers: headers }

      it 'should return 201 status' do
        expect(response).to have_http_status(201)
      end

      it 'creates a comment' do
        recipe.reload
        expect(recipe.comments.last.body).to eq('New comment')
      end
    end

    context 'invalid body' do
      before { post '/api/v1/comments', params: {user_id: user.id, body: 'New comment'}.to_json, headers: headers }

      it 'should return 422 status' do
        expect(response).to have_http_status(422)
      end

      it 'should not create a comment' do
        recipe.reload
        expect(recipe.comments.count).to eq 0
      end
    end
  end
end
