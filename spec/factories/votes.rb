FactoryBot.define do
  factory :vote do
    association :votable, factory: [:question, :answer]
    association :user
    liked { true }
  end
end
