FactoryBot.define do
  factory :user do
    full_name Faker::Name.name
    email Faker::Internet.email
    password 'asdf1234'
    password_confirmation 'asdf1234'
  end

  factory :project do
    name Faker::Name.name
    description Faker::Lorem.sentence(3, true)
    user
    due_date 10.days.from_now
    status :in_process
  end

  factory :client do
    full_name Faker::Name.name
    email Faker::Internet.email
    phone Faker::PhoneNumber.cell_phone
  end
end