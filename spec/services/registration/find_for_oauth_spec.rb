require 'rails_helper'

RSpec.describe Registration::FindForOauth do
  let!(:user) { create(:user) }
  let(:auth) { OmniAuth::AuthHash.new(provider: 'github', uid: '123') }
  subject { Registration::FindForOauth.new(auth) }

  context 'User has authorization already' do
    it 'returns the User' do
      user.authorizations.create(provider: 'github', uid: '123')
      expect(subject.call).to eq user
    end
  end

  context 'User has not authorization' do
    context 'User exist already' do
      let!(:auth) { OmniAuth::AuthHash.new(provider: 'github', uid: '123', info: { email: user.email }) }
      it 'does not create a new User' do
        expect { subject.call }.to_not change(User, :count)
      end

      it 'create new Authorization' do
        expect { subject.call }.to change(user.authorizations, :count).by(1)
      end

      it 'create authorization with provider and uid' do
        authorization = subject.call.authorizations.first

        expect(authorization.provider).to eq auth.provider
        expect(authorization.uid).to eq auth.uid
      end

      it 'returns the user' do
        expect(subject.call).to eq user
      end
    end

    context 'User does not exist' do
      let!(:auth) { OmniAuth::AuthHash.new(provider: 'github', uid: '123', info: { email: 'new@user.com' }) }

      it 'create a new User' do
        expect { subject.call }.to change(User, :count).by(1)
      end

      it 'returns the new User' do
        expect(subject.call).to be_a(User)
      end

      it 'fills user email' do
        user = subject.call
        expect(user.email).to eq auth.info[:email]
      end

      it 'create authorization for user' do
        user = subject.call

        expect(user.authorizations).to_not be_empty
      end

      it 'create authorization with probider and uid' do
        authorization = subject.call.authorizations.first

        expect(authorization.provider).to eq auth.provider
        expect(authorization.uid).to eq auth.uid
      end
    end
  end
end
