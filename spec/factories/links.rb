FactoryBot.define do
  factory :link do
    name { 'MyString' }
    url { 'MyString' }
    association :linkable, facory: %i[question answer]
  end
end
