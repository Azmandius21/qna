require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET#exctract_email' do
    before { get :extract_email }
    it 'assign new user' do
      expect(assigns(:user)).to be_a_new User
    end

    it 'render extract_email view' do
      expect(response).to render_template :extract_email
    end
  end

  describe 'POST #confirm_email' do
    let!(:user_attr){ attributes_for(:user) }
    let(:oauth_data){ { 'provider' => 'github', 'uid' => '123' } }

    it 'confirm email and create User' do
      expect do
        post :confirm_email, params: { user: user_attr },
        session: { uid: oauth_data['uid'],
                   provider: oauth_data['provider'] }
      end.to change(User, :count).by(1)
    end

    it 'create new authorization' do
      expect do
        post :confirm_email, params: { user: user_attr },
        session: { uid: oauth_data['uid'],
                   provider: oauth_data['provider'] }
      end.to change(Authorization, :count).by(1)
    end

    it 'render root path' do
      post :confirm_email, params: { user: user_attr },
        session: { uid: oauth_data['uid'],
                   provider: oauth_data['provider']}

      expect(response).to render_template root_path
    end
  end
end
