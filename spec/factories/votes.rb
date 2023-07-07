FactoryBot.define do
  factory :vote do
    association :votable, factory: :question
    association :user
    liked { true }
  end
end
