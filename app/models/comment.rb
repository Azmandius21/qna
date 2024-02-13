class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true, touch: true

  validates :body, presence: true

  def commentable_instance
    commentable_type.constantize.find(commentable_id)
  end
end
