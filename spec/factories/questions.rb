require 'byebug'
FactoryBot.define do
  factory :question do   
    transient { author { create(:user).id } }
    title { "#{['Title1', 'Title2', 'Title3'].sample}"}
    body { 'MyText' }
    author_id { author }   
    
    trait :invalid do
      title { nil }
    end

    trait :without_author do
      title { "#{['Title1', 'Title2', 'Title3'].sample}"}
      body { 'MyText' }
    end
  end
end