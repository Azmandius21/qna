FactoryBot.define do
  factory :question do   
    title { "#{['Title1', 'Title2', 'Title3'].sample}"}
    body { 'MyText' }

    trait :invalid do
      title { nil }
    end
  end
end
