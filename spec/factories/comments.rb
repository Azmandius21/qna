FactoryBot.define do
  factory :comment do
    body { "MyComment" }
    user
    association :commentable, facory: [:question, :answer]
  end
end
