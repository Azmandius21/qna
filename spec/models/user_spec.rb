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
    let(:service){ User::FindForOauth.new(auth) }
   
    it 'call service User::FindForOauth' do
      expect(User::FindForOauth).to receive(:new).with(auth).and_return(service)
      expect(service).to receive(:call)
      User.find_for_oauth(auth)
    end
  end
end
