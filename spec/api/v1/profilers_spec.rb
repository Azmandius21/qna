require 'rails_helper'

describe 'Profile API', type: :request do
  let(:headers){ { "CONTENT_TYPE" => 'application/json',
                 "ACCEPT" => 'application/json' } }

  describe 'GET /api/v1/profiles/me' do
    context 'unauthorized' do
      it 'returns 401 status if there is no acces_token' do
        get '/api/v1/profiles/me', headers: headers
        expect(response.status).to eq 401
      end

      it 'returns 401 status if acces_token is invaled' do
        get '/api/v1/profiles/me', params: { acces_token: 123 }, headers: headers
        expect(response.status).to eq 401
      end
    end
  end
end
