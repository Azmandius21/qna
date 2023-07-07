class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :votable, polymorphic: true

  def self.rank_of_votable(votable)
    if votable.votes.empty?
      return "Rank of whis #{votable.class}: 0"
    else
      rank = votable.votes.where(liked: true).count*2 - votable.votes.count
      return "Rank of whis #{votable.class}: #{rank}"
    end
  end
end
