require 'rails_helper'

RSpec.describe 'Listing Recipes', type: :request do
  describe 'GET /recipes' do
    let!(:list) { create_list }
    before {  get '/api//v1/recipes' }

    it 'list recipes' do
      expect(json).not_to be_empty
      expect(json.size).to eq 3
    end

    it 'return status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /recipes/:id' do
    let(:recipe) { FactoryBot.create(:recipe) }

    before { get "/api/v1/recipes/#{recipe.id}" }

    it 'list the correct resource' do
      expect(json['id']).to eq recipe.id
    end
  end
end

def create_list
  (1..3).each { FactoryBot.create(:recipe) }
end