FactoryBot.define do
  sequence :email do |n|
    "user#{n}@test.com"
  end

  factory :user, aliases: [:author] do
    email
    password { '123456' }
    password_confirmation { '123456' }
    admin { false }
    email_confirmed { true }
    confirmed_at { Time.now }

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

    trait :not_confirmed do
      after(:create) { |user| user.email_confirmed = false }
    end
  end
end
