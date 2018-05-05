require 'rails_helper'

RSpec.describe 'Creating Recipes', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:headers) { valid_headers }
  let(:valid_attributes) {
    { 
      name: 'Recipe 1',
      description: 'Simple Description',
      ingredients: ['Milk', 'Cheese', 'Tofu', 'Chicken'],
      directions: ['Mix them together', 'Add spices', 'Cook until turn brown'],
      user_id: user.id
    }.to_json
  }

  describe 'POST /recipes' do
    context 'valid request with correct parameters' do
      before { post '/api/v1/recipes', params: valid_attributes, headers: headers }

      it 'creates a recipe' do
        expect(json['name']).to eq 'Recipe 1'
      end

      it 'returns the 201 status' do
        expect(response).to have_http_status(201)
      end
    end

    context 'invalid request' do
      before { post '/api/v1/recipes', params: { name: 'Recipe 1' }.to_json, headers: headers }

      it 'returns the error 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns the error message' do
        expect(json['description'].first).to eq "can't be blank"
        expect(json['ingredients'].first).to eq "can't be blank"
        expect(json['directions'].first).to eq "can't be blank"
      end
    end
  end
end
