require 'rails_helper'

RSpec.describe 'Voting specs', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:recipe) { FactoryBot.create(:recipe, user: user) }
  let(:comment) { FactoryBot.create(:comment, user: user, recipe: recipe) }
  let!(:vote) { recipe.votes.create(status: 1, user: user) }
  let(:headers) { valid_headers }

  describe 'Voting Recipes' do
    describe 'POST /api/v1/recipes/:id/upvote' do
      before { recipes_post_request('recipe', recipe.id, user.id, 'upvote', headers) }

      it 'should be successful and return 201' do
        expect(response).to have_http_status(201)
      end

      it 'should increase number of upvotes on recipe' do
        expect(recipe.votes.upvotes.count).to eq 2
        expect(recipe.votes.downvotes.count).to eq 0
      end
    end

    describe 'POST /api/v1/recipes/:id/downvote' do
      before { recipes_post_request('recipe', recipe.id, user.id, 'downvote', headers) }

      it 'should be succesful and return 201' do
        expect(response).to have_http_status(201)
      end

      it 'should downvote the recipe' do
        expect(recipe.votes.upvotes.count).to eq 1
        expect(recipe.votes.downvotes.count).to eq 1
      end
    end
  end


  describe 'Voting Comments' do
    describe 'POST /api/v1/comments/:id/upvote' do
      before { comments_post_request(recipe.id, 'comment', comment.id, user.id, 'upvote', headers) }

      it 'should be successful and return 201' do
        expect(response).to have_http_status(201)
      end

      it 'should increase number of upvotes on comment' do
        expect(comment.votes.upvotes.count).to eq 1
        expect(comment.votes.downvotes.count).to eq 0
      end
    end

    describe 'POST /api/v1/comments/:id/downvote' do
      before { comments_post_request(recipe.id, 'comment', comment.id, user.id, 'downvote', headers) }

      it 'should be succesful and return 201' do
        expect(response).to have_http_status(201)
      end

      it 'should downvote the recipe' do
        expect(comment.votes.upvotes.count).to eq 0
        expect(comment.votes.downvotes.count).to eq 1
      end
    end
  end
end

def recipes_post_request(votable_type, votable_id, user_id, vote_type, headers)
  post "/api/v1/recipes/#{votable_id}/#{vote_type}",
    headers: headers,
    params: {votable_type: votable_type, votable_id: votable_id, user_id: user_id}.to_json
end

def comments_post_request(recipe_id, votable_type, votable_id, user_id, vote_type, headers)
  post "/api/v1/recipes/#{recipe_id}/#{votable_type.pluralize}/#{votable_id}/#{vote_type}",
    headers: headers,
    params: {votable_type: votable_type, votable_id: votable_id, user_id: user_id}.to_json
end
