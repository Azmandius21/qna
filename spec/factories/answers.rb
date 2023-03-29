FactoryBot.define do

  factory :answer do
    body { "#{['MyText1', 'MyText2', 'MyText3'].sample}" }
    question_id { nil }

    trait :invalid do
      body { nil }
    end
  end
end
