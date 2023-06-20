class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :author, class_name: 'User'
  has_many :links, dependent: :destroy, as: :linkable

  accepts_nested_attributes_for :links, reject_if: :all_blank, allow_destroy: true

  has_many_attached :files

  validates :body, :question_id, :author_id, presence: true

  def mark_as_best
    question.update(best_answer_id: id)
    if question.reward.present?

      GivingReward.create(reward_id: question.reward.id, user_id: self.author.id)
    end
  end
end
