class Reward < ApplicationRecord
  belongs_to :rewardable, polymorphic: true
  has_one :giving_reward
  has_one :user, through: :giving_reward

  has_one_attached :image

  validates :name, :image, presence: true
end
