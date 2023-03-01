require 'faker'
FactoryBot.define do
  factory :user do |f|
    f.name { Faker::Name.first_name }
    f.phone { Faker::Number.number(digits: 11) }
    f.email { Faker::Internet.email }
  end
end