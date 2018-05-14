require 'rails_helper'

RSpec.describe 'Deleting comments', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:recipe) { FactoryBot.create(:recipe, user: user) }
  let(:comment) { FactoryBot.create(:comment, user: user, recipe: recipe) }
  let(:headers) { valid_headers }

  describe 'DELETE /api/v1/recipes/:recipe_id/comments/:id' do
    context 'if comment actually exists' do
      before { delete "/api/v1/recipes/#{recipe.id}/comments/#{comment.id}", headers: headers }

      it 'should delete the comment' do
        expect { comment.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it 'should return 204 status' do
        expect(response).to have_http_status(204)
      end
    end
  end
end
