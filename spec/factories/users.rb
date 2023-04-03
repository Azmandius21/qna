FactoryBot.define do
  sequence :email do |n|
    "user#{n}@test.com"
  end

  factory :user, aliases: [:author] do
    email
    password { '123456' }
    password_confirmation { '123456' }

    trait :with_question do
      after(:create) do |user|
        user.questions << FactoryBot.create(:question)
      end
    end

    trait :with_answer do
      after(:create) do |user|
        user.questions << FactoryBot.create(:answer)
      end
    end
  end
end
