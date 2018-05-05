require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  let!(:user) { FactoryBot.create(:user) }
  let(:headers) { { 'Authorization' => token_generator(user.id) } }
  let(:invalid_headers) { { 'Authorization' => nil } }

  describe '#authorize_request' do
    context 'when auth token is present' do
      before { allow(request).to receive(:headers).and_return(headers) }
      it 'sets the current user' do
        expect(subject.instance_eval { authorize_request }).to eq(user)
      end
    end

    context 'when auth token is not present' do
      before { allow(request).to receive(:headers).and_return(invalid_headers) }

      it 'raises MissingToken error' do
        expect { subject.instance_eval { authorize_request } }
          .to raise_error(ExceptionHandler::MissingToken)
      end
    end
  end
end
