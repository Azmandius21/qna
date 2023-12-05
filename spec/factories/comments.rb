FactoryBot.define do
  factory :comment do
    body { 'MyComment' }
    user { create(:user) }
    association :commentable, factory: %i[questions answers]
  end
end
