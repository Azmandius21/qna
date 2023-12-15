FactoryBot.define do
  factory :link do
    name { 'MyLink' }
    url { 'http://mylink.com' }
    association :linkable, factory: %i[question answer]
  end
end
