class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[ github twitter vkontakte ]

  has_many :questions, class_name: 'Question', dependent: :destroy, foreign_key: 'author_id'
  has_many :answers, class_name: 'Answer', dependent: :destroy, foreign_key: 'author_id'
  has_many :giving_rewards, dependent: :destroy
  has_many :rewards, through: :giving_rewards
  has_many :votes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :authorizations, dependent: :destroy

  def self.find_for_oauth(auth)
    User::FindForOauth.new(auth).call
  end

  def author?(subject)
    id.eql?(subject.author_id)
  end

  def find_vote_for(votable)
    votes.where(votable_type: votable.class.name,
                votable_id: votable.id)&.sample
  end

  def can_vote_for?(votable)
    votable.votes.where(user_id: id).empty?
  end

  def create_authorization(auth)
    self.authorizations.create(provider: auth.provider, uid: auth.uid.to_s)
  end
end
