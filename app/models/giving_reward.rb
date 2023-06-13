class GivingReward < ApplicationRecord
  belongs_to :reward
  belongs_to :user
end
