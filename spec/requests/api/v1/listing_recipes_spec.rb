require 'rails_helper'

RSpec.describe 'Listing Recipes', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:headers) { valid_headers }

  describe 'GET /recipes' do
    let!(:list) { create_list }
    before {  get '/api//v1/recipes', headers: headers }

    it 'list recipes with pictures' do
      expect(json).not_to be_empty
      expect(json.size).to eq 3
      expect(json.first['pictures']).to be_empty
    end

    it 'return status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /recipes/:id' do
    let(:recipe) { FactoryBot.create(:recipe, user: user) }
    let!(:picture) { FactoryBot.create(:picture, recipe: recipe) }
    context 'recipe with id exists' do
      before { get "/api/v1/recipes/#{recipe.id}", headers: headers }

      it 'list the correct resource with pictures' do
        expect(json).not_to be_empty
        expect(json['id']).to eq recipe.id
        expect(json['pictures'].first['file']['url']).to match(/rails-logo/)
      end

      it 'returns the 200 status' do
        expect(response).to have_http_status(200)
      end
    end

    context 'recipe does not exist' do
      before { get '/api/v1/recipes/10', headers: headers }

      it 'return the 404 http code' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns the not found error code' do
        expect(response.body).to match("Couldn't find Recipe with 'id'=10")
      end
    end
  end
end

def create_list
  user = FactoryBot.create(:user)
  (1..3).each { FactoryBot.create(:recipe, user: user) }
end
