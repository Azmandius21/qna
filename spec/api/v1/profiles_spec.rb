require 'rails_helper'

describe 'Profile API', type: :request do
  let(:headers){ { "CONTENT-TYPE" => 'application/json',
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

    context 'authorized' do
      let!(:me){ create(:user) }
      let(:access_token){ create(:access_token, resource_owner_id: me.id) }

      before { get '/api/v1/profiles/me', params: { access_token: access_token.token }, headers: headers }

      it 'return 200 status' do
        expect(response).to be_successful
      end

      it 'return all public fields' do
        %w[id email admin created_at].each do |attr|
          expect(json[attr]).to eq me.send(attr).as_json
        end
      end

      it 'does not return private fields' do
        %w[password encrypted_password].each do |attr|
          expect(json).to_not have_key(attr)
        end
      end
    end
  end
end
