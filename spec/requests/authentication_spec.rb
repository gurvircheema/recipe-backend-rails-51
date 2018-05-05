require 'rails_helper'
require 'ffaker'

RSpec.describe AuthenticationController, type: :request do
  let(:user) { FactoryBot.create(:user) }

  let(:headers) { valid_headers.except(:Authorization) }

  let(:valid_credentials ) do
    {
      email: user.email,
      password: user.password
    }.to_json
  end

  let(:invalid_credentials) do
    {
      email: FFaker::Internet.email,
      password: FFaker::Internet.password
    }.to_json
  end

  describe 'POST /auth/login' do
    context 'when request is valid' do
      before { post '/auth/login', params: valid_credentials, headers: headers }

      it 'should return a auth token' do
        expect(json['auth_token']).not_to be_empty
      end
    end

    context 'when request is invalid' do
      before { post '/auth/login', params: invalid_credentials, headers: headers }

      it 'should return error invalid credentials' do
        expect(json['message']).to match(/Invalid credentials/)
      end
    end
  end
end
