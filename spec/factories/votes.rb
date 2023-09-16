FactoryBot.define do
  factory :vote do
    association :votable, factory: %i[question answer]
    association :user
    liked { true }
  end
end
