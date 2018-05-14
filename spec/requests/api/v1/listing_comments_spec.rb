require 'rails_helper'

RSpec.describe 'Listing comments', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:recipe) { FactoryBot.create(:recipe, user: user) }
  let(:headers) { valid_headers }
  let!(:comment1) { FactoryBot.create(:comment, recipe: recipe, user: user) }
  let!(:comment2) { FactoryBot.create(:comment, recipe: recipe, user: user) }
  let!(:vote) { comment1.votes.create(status: 0, user: user) }

  describe 'GET /api/v1/recipes/:recipe_id/comments' do
    before { get "/api/v1/recipes/#{recipe.id}/comments", headers: headers }

    it 'should return 200' do
      expect(response).to have_http_status(200)
    end

    it 'should return array of comments with count' do
      expect(json.size).to eq 2
      expect(json.first['upvotes_count']).to eq 0
      expect(json.first['downvotes_count']).to eq 1
    end
  end
end
