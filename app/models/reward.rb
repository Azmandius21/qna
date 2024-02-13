class Reward < ApplicationRecord
  has_one :giving_reward
  has_one :user, through: :giving_reward
  belongs_to :rewardable, polymorphic: true, touch: true

  has_one_attached :image

  validates :name, :image, presence: true
end
