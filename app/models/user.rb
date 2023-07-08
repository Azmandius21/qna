class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :questions, class_name: 'Question', dependent: :destroy, foreign_key: 'author_id'
  has_many :answers, class_name: 'Answer', dependent: :destroy, foreign_key: 'author_id'
  has_many :giving_rewards, dependent: :destroy
  has_many :rewards, through: :giving_rewards
  has_many :votes, dependent: :destroy

  def author?(subject)
    id.eql?(subject.author_id)
  end

  def find_vote_for(question)
    Vote.find_by(user_id: self.id, 
                 votable_type: 'Question',
                 votable_id: question.id)
  end

  def can_vote_for?(question)
    question.votes.where(user_id: self.id).empty?
  end


end
