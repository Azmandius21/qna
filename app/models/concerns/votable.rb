module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable
  end

  def detect_route_path(instance)
    resource = instance.class.name.downcase
    resource_id = ":#{resource}_id"
    return
  end
end