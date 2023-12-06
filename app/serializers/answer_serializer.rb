class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :body, :created_at, :updated_at
  has_many :comments
  has_many :links
  has_many :files, serializer: FileSerializer

  belongs_to :question
  belongs_to :author
end
