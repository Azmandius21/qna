FactoryBot.define do
  factory :answer do
    body { "#{['MyText1', 'MyText2', 'MyText3'].sample}" }
    association :question, factory: :question
    association :author, factory: :user

    trait :invalid do
      body { nil }
    end
  end
end
