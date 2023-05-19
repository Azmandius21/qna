FactoryBot.define do
  factory :answer do
    body { "#{['My answer1', 'My answer2', 'My answer3'].sample}" }
    association :question, factory: :question
    association :author, factory: :user

    trait :invalid do
      body { nil }
    end

    trait :with_attached_files do
      after(:build) do |answer|
        answer.files.attach(
          io: File.open(Rails.root.join('spec', 'support', 'assets', 'test-image.png')),
          filename: 'test-image.png',
          content_type: 'image/png'
        )
      end
    end
  end
end
