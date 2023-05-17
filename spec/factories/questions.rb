FactoryBot.define do
  factory :question do
    title { "#{%w[Title1 Title2 Title3].sample}" }
    body { 'MyText' }
    association :author, factory: :user
    best_answer_id { nil }
    
    trait :invalid do
      title { nil }
    end

    trait :with_attached_files do
      after(:build) do |question|
        question.files.attach(
          io: File.open("#{Rails.root}/spec/support/assets/test-image.png"),
          filename: 'test-image.png',
          content_type: 'image/png'
         )
      end
    end
  end
end
