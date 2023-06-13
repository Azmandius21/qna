class Reward < ApplicationRecord
  has_one :giving_reward

  has_one_attached :image

  validates :name, presence: true
end
