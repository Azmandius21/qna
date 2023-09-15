class Question < ApplicationRecord
  include Votable
  include Commentable

  has_many :answers, dependent: :destroy, inverse_of: :question
  has_many :links, dependent: :destroy, as: :linkable
  has_one :reward, dependent: :destroy, as: :rewardable

  accepts_nested_attributes_for :links, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :reward, reject_if: :all_blank

  has_many_attached :files

  belongs_to :author, class_name: 'User'
  belongs_to :best_answer, class_name: 'Answer', optional: true

  validates :title, :body, :author_id, presence: true
end
