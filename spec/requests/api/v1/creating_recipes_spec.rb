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
      pictures_data: [
        file_fixture('picture.txt').read,
        file_fixture('picture.txt').read
      ],
      user_id: user.id
    }.to_json
  }

  describe 'POST /recipes' do
    context 'valid request with correct parameters' do
      before { post '/api/v1/recipes', params: valid_attributes, headers: headers }

      it 'creates a recipe with a picture attached' do
        expect(json['name']).to eq 'Recipe 1'
        expect(json['pictures']).to_not be_empty
        expect(json['pictures'].size).to eq 2
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
