FactoryBot.define do
  factory :user do
    full_name Faker::Name.unique.name
    email Faker::Internet.unique.email
    password 'asdf1234'
    password_confirmation 'asdf1234'
  end

  factory :project do
    name Faker::Name.name
    description Faker::Lorem.sentence(3, true)
    user
    client
    due_date 10.days.from_now
    status :in_process
  end

  factory :client do
    full_name Faker::Name.name
    email Faker::Internet.email
    phone Faker::PhoneNumber.cell_phone
  end

  factory :expense do
    amount Faker::Number.decimal(2)
  end

  factory :task do
    name Faker::Name.name
    description Faker::Lorem.sentence(3, true)
    due_date Faker::Date.forward(10)
    status :done
    project
  end
end