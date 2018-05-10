require 'rails_helper'

RSpec.describe 'Deleting Pictures', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:recipe) { FactoryBot.create(:recipe, user: user) }
  let(:picture) { FactoryBot.create(:picture, recipe: recipe) }
  let(:headers) { valid_headers }

  describe 'DELETE /api/v1/pictures/:id' do
    before { delete "/api/v1/pictures/#{picture.id}", headers: headers }

    it 'should delete the picture' do
      expect(response).to have_http_status(204)
      expect { picture.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
