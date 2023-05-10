FactoryBot.define do
  factory :question do
    title { "#{%w[Title1 Title2 Title3].sample}" }
    body { 'MyText' }
    association :author, factory: :user
    best_answer_id { nil }
    trait :invalid do
      title { nil }
    end
  end
end
