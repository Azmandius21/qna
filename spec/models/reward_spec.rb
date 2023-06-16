require 'rails_helper'

RSpec.describe Reward, type: :model do
  it { should have_one :giving_reward }
  it { should validate_presence_of :name }
  it { should have_one_attached :image }
end
