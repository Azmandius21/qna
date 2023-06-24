class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :questions, class_name: 'Question', dependent: :destroy, foreign_key: 'author_id'
  has_many :answers, class_name: 'Answer', dependent: :destroy, foreign_key: 'author_id'
  has_many :giving_rewards, dependent: :destroy
  has_many :rewards, through: :giving_rewards

  def author?(subject)
    id.eql?(subject.author_id)
  end
end
