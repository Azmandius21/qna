require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should have_many :questions }
  it { should have_many :answers }
  it { should have_many :giving_rewards }
  it { should have_many :rewards }
  it { should have_many(:votes).dependent(:destroy) }
  it { should have_many(:authorizations).dependent(:destroy) }

  describe '.find_for_oauth' do
    let!(:user){ create(:user) }
    let(:auth){ OmniAuth::AuthHash.new(provider: 'github', uid: '123') }
    context 'User has authorization already' do
      it 'returns the User' do
        user.authorizations.create(provider: 'github', uid: '123')
        expect(User.find_for_oauth(auth)).to eq user
      end
    end

    context 'User has not authorization' do
      context 'User exist already' do
        let!(:auth){ OmniAuth::AuthHash.new(provider: 'github', uid: '123', info: { email: user.email }) }
        it 'does not create a new User' do
          expect {User.find_for_oauth(auth)}.to_not change(User, :count)
        end

        it 'create new Authorization' do
          expect {User.find_for_oauth(auth)}.to change(user.authorizations, :count).by(1)
        end

        it 'create authorization with provider and uid' do
          authorization = User.find_for_oauth(auth).authorizations.first

          expect(authorization.provider).to eq auth.provider
          expect(authorization.uid).to eq auth.uid
        end

        it 'returns the user' do
          expect(User.find_for_oauth(auth)).to eq user
        end
      end 

      context 'User does not exist' do
        let!(:auth){ OmniAuth::AuthHash.new(provider: 'github', uid: '123', info: { email: 'new@user.com' }) }

        it 'create a new User' do
          expect { User.find_for_oauth(auth) }.to change(User, :count).by(1)
        end

        it 'returns the new User' do
          expect(User.find_for_oauth(auth)).to be_a(User)  
        end

        it 'fills user email' do
          user = User.find_for_oauth(auth)
          expect(user.email).to eq auth.info[:email]
        end

        it 'create authorization for user' do
          user = User.find_for_oauth(auth)

          expect(user.authorizations).to_not be_empty
        end

        it 'create authorization with probider and uid' do
          authorization = User.find_for_oauth(auth).authorizations.first

          expect(authorization.provider).to eq auth.provider
          expect(authorization.uid).to eq auth.uid
        end
      end
    end
  end
end
