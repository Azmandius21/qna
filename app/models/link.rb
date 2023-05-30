class Link < ApplicationRecord
  GIST_URL = Regexp.new 'https://gist.github.com'.freeze
  belongs_to :linkable, polymorphic: true
  
  validates :name, :url, presence: true

  validates_format_of :url, with: URI.regexp, message: 'Invalid format links'

  def gist?
    self.url.match?(GIST_URL)
  end
end
