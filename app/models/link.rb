class Link < ApplicationRecord
  GIST_URL = Regexp.new 'https://gist.github.com/\w+/\w+'.freeze
  belongs_to :linkable, polymorphic: true
  
  validates :name, :url, presence: true

  validates_format_of :url, with: URI.regexp, message: 'Invalid format links'

  def gist?
    self.url.match?(GIST_URL)
  end

  def give_gist_id
    if self.gist?
      self.url.match(%r{https://gist.github.com/\w+/(?<gist_id>\w+)})['gist_id']
    end
  end
end
