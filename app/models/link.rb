class Link < ApplicationRecord
  belongs_to :linkable, polymorphic: true
  
  validates :name, :url, presence: true,
            format: { with: URI.regexp, message: 'Invalid format links url'}
end
