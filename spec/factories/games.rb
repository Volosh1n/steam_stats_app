FactoryBot.define do
  factory :game do
    name { FFaker::Lorem.word }

    trait :with_statistic do
      after(:create) do |game|
        create(:statistic, game: game)
      end
    end
  end
end
