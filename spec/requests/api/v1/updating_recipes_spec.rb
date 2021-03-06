require 'rails_helper'

RSpec.describe 'Updating Recipes', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let!(:recipe) { FactoryBot.create(:recipe, user: user) }
  let(:headers) { valid_headers }

  describe 'PUT /api/v1/recipes/:id' do
    context 'valid request with correct parameters' do
      before { put "/api/v1/recipes/#{recipe.id}", params: { name: 'Updated'}.to_json, headers: headers }

      it 'updates the recipe' do
        recipe.reload
        expect(recipe.name).to eq 'Updated'
      end

      it 'returns the 204 status' do
        expect(response).to have_http_status(204)
      end
    end

    context 'uploading new images' do
      before do
        put "/api/v1/recipes/#{recipe.id}",
          params: {pictures_data: [file_fixture('picture.txt').read]}.to_json,
          headers: headers
      end

      it 'saves the new picture(s)' do
        recipe.reload
        expect(recipe.pictures.size).to eq 1
      end

      it 'returns the 204 status' do
        expect(response).to have_http_status(204)
      end
    end

    context 'invalid request' do
      before { put "/api/v1/recipes/#{recipe.id}", params: { name: ''}.to_json, headers: headers }

      it 'returns the error 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns the error message' do
        expect(json['name'].first).to match "can't be blank"
      end
    end
  end
end
