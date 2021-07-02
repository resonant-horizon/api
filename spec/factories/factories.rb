FactoryBot.define do
  factory :organization do
    name { Faker::Mountain.name }
    contact_name { Faker::Name.name }
    contact_email { Faker::Internet.email }
    phone_number { '1112223344' }
    street_address { Faker::Address.street_address }
    city { "McAllen" }
    state { "TX" }
    zip { '78503' }
    user { User.first }
  end

  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    phone_number { "3333333333" }
    email { Faker::Internet.email }
  end

  factory :employee do
    first_name   { Faker::Name.first_name }
    last_name    { Faker::Name.last_name }
    phone_number { "3333333333" }
    email        { Faker::Internet.email }
    full_legal_name { Faker::Name.name }
    street   { Faker::Address.street_address }
    city     { Faker::Address.city }
    state    { Faker::Address.state_abbr }
    zip      { Faker::Address.zip }
    ssn      { Faker::Number.number(digits: 6)}
    passport_number { Faker::Number.number(digits: 10) }
    passport_issue_date { Faker::Date.backward(days: 14) }
    passport_expiration { Faker::Date.forward(days: 500) }
    birthdate { Faker::Date.birthday(min_age: 18, max_age: 99)}
    birth_place { Faker::Address.city }
    nationality { Faker::Nation.nationality }
    passport_sex { 1 }
    american_frequent_flyer { Faker::Alphanumeric.alphanumeric(number: 6) }
    delta_frequent_flyer { Faker::Alphanumeric.alphanumeric(number: 6) }
    united_frequent_flyer { Faker::Alphanumeric.alphanumeric(number: 6) }
    organization { Organization.first}
    union_designee { false }
    employment_status { 1 }
  end
end
