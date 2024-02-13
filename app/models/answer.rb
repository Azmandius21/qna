class Answer < ApplicationRecord
  include Votable
  include Commentable

  has_many :links, dependent: :destroy, as: :linkable
  belongs_to :question, touch: true
  belongs_to :author, class_name: 'User'

  accepts_nested_attributes_for :links, reject_if: :all_blank, allow_destroy: true

  has_many_attached :files

  validates :body, :question_id, :author_id, presence: true

  after_create :notify_subscribers

  def mark_as_best
    question.update(best_answer_id: id)
    GivingReward.create(reward_id: question.reward.id, user_id: author.id) if question.reward.present?
  end

  def is_best?
    question.best_answer_id == id
  end

  private

  def notify_subscribers
    NotifySubscribersJob.perform_later(self)
  end
end
