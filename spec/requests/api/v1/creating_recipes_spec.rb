require 'rails_helper'

RSpec.describe 'Creating Recipes', type: :request do
  let(:valid_attributes) {
    { 
      name: 'Recipe 1',
      description: 'Simple Description',
      ingredients: ['Milk', 'Cheese', 'Tofu', 'Chicken'],
      directions: ['Mix them together', 'Add spices', 'Cook until turn brown']
    }
  }

  describe 'POST /recipes' do
    context 'valid request with correct parameters' do
      before { post '/api/v1/recipes', params: valid_attributes }

      it 'creates a recipe' do
        expect(json['name']).to eq 'Recipe 1'
      end

      it 'returns the 201 status' do
        expect(response).to have_http_status(201)
      end
    end

    context 'invalid request' do
      before { post '/api/v1/recipes', params: { name: 'Recipe 1' }}

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