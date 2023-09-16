FactoryBot.define do
  factory :comment do
    body { 'MyComment' }
    user
    association :commentable, facory: %i[question answer]
  end
end
