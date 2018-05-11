require 'rails_helper'

RSpec.describe 'Searching Recipes', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:recipe) { FactoryBot.create(:recipe, name: 'Example', user: user) }
  let(:headers) { valid_headers }

  describe '/api/v1/recipes/search' do
    before do
      post '/api/v1/recipes/search',
        params: {search_for: recipe.name}.to_json,
        headers: headers
    end

    it 'returns the matching recipes' do
      expect(json).not_to be_empty
      expect(json.first).to eq(JSON.parse(recipe.to_json))
    end
  end
end
