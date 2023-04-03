FactoryBot.define do

  factory :answer do
    #transient { author { create(:user).id }}
    #author_id { author }
    body { "#{['MyText1', 'MyText2', 'MyText3'].sample}" }
    question_id { nil }
    author_id { nil }

    trait :invalid do
      body { nil }
    end
  end
end
