class QuestionsSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :created_at, :updated_at, :short_body

  has_many :answers
  belongs_to :author

  def short_body
    object.body.truncate(7)
  end
end
