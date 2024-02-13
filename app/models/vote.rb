class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :votable, polymorphic: true, touch: true

  def self.rank_of_votable(votable)
    if votable.votes.empty?
      'Rank : 0'
    else
      rank = votable.votes.where(liked: true).count * 2 - votable.votes.count
      "Rank : #{rank}"
    end
  end
end
