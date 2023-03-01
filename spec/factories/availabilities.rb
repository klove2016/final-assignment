require 'faker'


FactoryBot.define do
  factory :availability do
    title { Faker::Lorem.sentence }
    start_time { Date.today }
    end_time { (Date.today + 1.day)}
    user
  end
end

