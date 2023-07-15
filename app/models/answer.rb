class Answer < ApplicationRecord
  has_many :links, dependent: :destroy, as: :linkable
  belongs_to :question
  belongs_to :author, class_name: 'User'

  accepts_nested_attributes_for :links, reject_if: :all_blank, allow_destroy: true

  has_many_attached :files

  include Votable
  
  def mark_as_best
    question.update(best_answer_id: id)
    GivingReward.create(reward_id: question.reward.id, user_id: author.id) if question.reward.present?
  end
end
