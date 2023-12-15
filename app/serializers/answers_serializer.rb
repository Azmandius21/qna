class AnswersSerializer < ActiveModel::Serializer
  attributes :id, :body
  belongs_to :author
end
