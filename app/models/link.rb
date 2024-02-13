class Link < ApplicationRecord
  GIST_URL = Regexp.new 'https://gist.github.com/\w+/\w+'.freeze
  belongs_to :linkable, polymorphic: true, touch: true

  validates :name, :url, presence: true

  validates_format_of :url, with: URI::DEFAULT_PARSER.make_regexp, message: 'Invalid format links'

  def gist?
    url.match?(GIST_URL)
  end

  def give_gist_id
    url.match(%r{https://gist.github.com/\w+/(?<gist_id>\w+)})['gist_id'] if gist?
  end
end
