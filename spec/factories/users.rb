FactoryBot.define do
  sequence :email do |n|
    "user#{n}@test.com"
  end

  factory :user, aliases: [:author] do
    email
    password { '123456' }
    password_confirmation { '123456' }
    admin { false }

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

    trait :with_email_confirmed do
      after(:create) do |user|
        user.email_confirmed = true
        user.confirmed_at = Time.now
      end
    end
  end
end
