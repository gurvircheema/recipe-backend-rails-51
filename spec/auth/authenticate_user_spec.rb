require 'rails_helper'

RSpec.describe AuthenticateUser do
  let(:user) { FactoryBot.create(:user) }
  subject(:valid_auth_obj) { described_class.new(user.email, user.password) }
  subject(:invalid_auth_obj) { described_class.new('foo@gmail.com', 'foobar') }

  describe '#call' do
    context 'valid authentication' do
      it 'should return auth token' do
        expect(valid_auth_obj.call).not_to eq(nil)
      end
    end

    context 'invalid authentication' do
      it 'should through exception' do
        expect { invalid_auth_obj.call }
          .to raise_error(
            ExceptionHandler::AuthenticationError,
            /Invalid credentials/
          )
      end
    end
  end
end
