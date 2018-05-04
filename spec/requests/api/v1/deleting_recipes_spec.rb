require 'rails_helper'

RSpec.describe 'Deleting Recipes', type: :request do
  let!(:recipe) { FactoryBot.create(:recipe) }

  context 'when record exists' do
    before { delete "/api/v1/recipes/#{recipe.id}" }

    it 'deletes the recipe' do
      expect(Recipe.all).not_to include(recipe)
    end

    it 'returns the 204 status' do
      expect(response).to have_http_status(204)
    end
  end
end