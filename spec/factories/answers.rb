FactoryBot.define do
  factory :answer do
    body { "#{['My answer1', 'My answer2', 'My answer3'].sample}" }
    association :question, factory: :question
    association :author, factory: :user

    trait :invalid do
      body { nil }
    end
  end
end
