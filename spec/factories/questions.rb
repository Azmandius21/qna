FactoryBot.define do
  factory :question do   
    title { "#{['Title1', 'Title2', 'Title3'].sample}"}
    body { 'MyText' }
    association :author, factory: :user
    
    trait :invalid do
      title { nil }
    end
  end
end