FactoryBot.define do
  factory :reward do
    association :rewardable, factory: :question
    name { 'MyReward' }

    after(:build) do |reward|
      reward.image.attach(
        io: File.open("#{Rails.root}/spec/support/assets/reward.png"),
        filename: 'reward.png',
        content_type: 'image/png'
      )
    end
  end
end
