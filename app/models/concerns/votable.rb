module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, dependent: :destroy, as: :votable
  end

  def detect_route_path
    resource = self.class.name.downcase

    "/#{resource.pluralize}/#{id}/votes.json?"
  end

  def self.find_votable(params)
    attr_id = params.keys.select { |key| key if key =~ /_id$/ }.first
    votable = attr_id.split('_')[0].capitalize.constantize
    @votable = votable.find(params[attr_id].to_i)
  end

  def voted_by?(user)
    votes.where(user_id: user.id).any?
  end

  def vote_sum
    votes.where(liked: true).count - votes.where(liked: false).count
  end
end
