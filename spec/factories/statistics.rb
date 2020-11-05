FactoryBot.define do
  factory :statistic do
    current_players { rand(1..100) }
    peak_today { rand(1..100) }
    game
  end
end
