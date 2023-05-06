class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  belongs_to :author, class_name: 'User'
  belongs_to :best_answer, class_name: 'Answer'
  validates :title, :body, :author_id, presence: true
end
