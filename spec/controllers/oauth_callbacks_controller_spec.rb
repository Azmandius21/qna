require 'rails_helper'

RSpec.describe OauthCallbacksController, type: :controller do
  before { @request.env["devise.mapping"] = Devise.mappings[:user] }
  describe 'Github' do
    let(:oauth_data){ { 'provider' => 'github', 'uid' => '123' } }
    it 'find user from auth data' do
      allow(request.env).to receive(:[]).and_call_original 
      allow(request.env).to receive(:[]).with('omniauth.auth').and_return(oauth_data)
      expect(User).to receive(:find_for_oauth).with(oauth_data)
      get :github  
    end
    
    context 'User exist' do
      let!(:user) { create(:user) }

      before do
        allow(User).to receive(:find_for_oauth).and_return(user)
        get :github
      end

      it 'login user' do
        expect(subject.current_user).to eq user
      end

      it 'redirect to root path'do
        expect(response).to redirect_to root_path
      end
    end

    context 'User does not exist' do
      before do
        allow(User).to receive(:find_for_oauth)
        get :github
      end
      it 'redirect to root path' do
        expect(response).to redirect_to root_path
      end

      it 'does not login user'do
        expect(subject.current_user).to_not be
      end
    end
  end

  describe 'Vkontakte' do
    it 'find user from auth data' do
      expect(User)
    end
    context 'User exist' do
      it 'login user' 
      it 'redirect to root path'
    end

    context 'User does not exist' do
      it 'does not login user'
      it 'redirect to root path'
    end
  end
end