class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  belongs_to :author, class_name: :user, foreign_key: :user_id

  validates :title, :body, presence: true
end
