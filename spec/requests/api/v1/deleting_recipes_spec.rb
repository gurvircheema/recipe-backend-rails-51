require 'rails_helper'

RSpec.describe 'Deleting Recipes', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let!(:recipe) { FactoryBot.create(:recipe, user: user) }
  let(:headers) { valid_headers }

  context 'when record exists' do
    before { delete "/api/v1/recipes/#{recipe.id}", headers: headers }

    it 'deletes the recipe' do
      expect(Recipe.all).not_to include(recipe)
    end

    it 'returns the 204 status' do
      expect(response).to have_http_status(204)
    end
  end
end
