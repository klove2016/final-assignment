require 'faker'

 
FactoryBot.define do
  factory :availability do
    title { Faker::Lorem.sentence }
    start_time { Faker::Time.between(from: Time.now, to: 1.week.from_now).beginning_of_day }
    end_time { start_time + 1.hour }
    user { association :user }
    # Ensure that the generated availability does not overlap with existing availabilities for the same user
    
  end
end


