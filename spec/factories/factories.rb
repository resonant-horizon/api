FactoryBot.define do
  factory :organization do
    name           { Faker::Mountain.name }
    contact_name   { Faker::Name.name }
    contact_email  { Faker::Internet.email }
    phone_number   { '1112223344' }
    street_address { Faker::Address.street_address }
    city           { "McAllen" }
    state          { "TX" }
    zip            { '78503' }
    user           { User.first }
  end

  factory :user do
    first_name   { Faker::Name.first_name }
    last_name    { Faker::Name.last_name }
    phone_number { "3333333333" }
    email        { Faker::Internet.email }
  end

  factory :employee do
    employment_status  { 1 }
    instrument_section { 2 }
    user               { User.first }
    organization       { Organization.first }

    factory :employee_with_all_data do
      after(:create) do |employee|
        create(:biography, employee: employee)
        create(:traveler, employee: employee)
        create(:passport, employee: employee)
        create(:employee_role, employee: employee)
      end
    end
  end

  factory :employee_role do
    employee { Employee.last }
    role     { create(:role) }
  end

  factory :role do
    name { ["concert manager",
     "stage manager",
     "music director",
     "associate conductor",
     "assistant conductor",
     "tour manager",
     "production manager",
     "company manager",
     "librarian",
     "concertmaster",
     "principal",
     "vice principal",
     "section",
     "guest artist",
     "videographer",
     "sound engineer",
     "usher",
     "stage crew",
     "lighting",
     "ceo",
     "coo",
     "cfo",
     "cto",
     "development"].sample }
  end

  factory :biography do
    employee        { Employee.last }
    first_name      { Faker::Name.first_name }
    last_name       { Faker::Name.last_name }
    phone_number    { "3333333333" }
    email           { Faker::Internet.email }
    full_legal_name { Faker::Name.name }
    street          { Faker::Address.street_address }
    city            { Faker::Address.city }
    state           { Faker::Address.state_abbr }
    zip             { Faker::Address.zip }
    ssn             { '999887777'}
  end

  factory :passport do
    surname         { Faker::Name.first_name }
    given_names     { Faker::Name.last_name }
    passport_number { '1856498839' }
    issue_date      { Faker::Date.backward(days: 14) }
    expiration_date { Faker::Date.forward(days: 500) }
    birthdate       { Faker::Date.birthday(min_age: 18, max_age: 99)}
    birth_place     { Faker::Address.city }
    nationality     { Faker::Nation.nationality }
    passport_sex    { (0..2).to_a.sample }
    employee        { Employee.last }
  end

  factory :traveler do
    employee        { Employee.last }
    seat_preference { (0..2).to_a.sample }
    american_ff     { Faker::Alphanumeric.alphanumeric(number: 6) }
    delta_ff        { Faker::Alphanumeric.alphanumeric(number: 6) }
    united_ff       { Faker::Alphanumeric.alphanumeric(number: 6) }
  end

  factory :season do
    name         { Faker::Mountain.name }
    organization { Organization.first }
    start_date   { Faker::Date.backward(days: 14) }
    end_date     { Faker::Date.forward(days: 500) }

    factory :season_with_basic_employee do
      after(:create) do |season|
        create(:employee, organization: season.organization)
        create(:season_employee)
      end
    end

    factory :season_with_full_employee do
      after(:create) do |season|
        create(:employee_with_all_data, organization: season.organization)
        create(:season_employee)
      end
    end
  end

  factory :season_employee do
    employee { Employee.last }
    season   { Season.last }
  end

  factory :tour do
    name         { Faker::Mountain.name }
    organization { Organization.last }
    start_date   { Faker::Date.backward(days: 14) }
    end_date     { Faker::Date.forward(days: 100) }

    factory :tour_with_basic_employee do
      after(:create) do |tour|
        create(:employee, organization: tour.organization)
        create(:tour_employee)
      end
    end

    factory :tour_with_full_employee do
      after(:create) do |tour|
        create(:employee_with_all_data, organization: tour.organization)
        create(:tour_employee)
      end
    end
  end

  factory :tour_employee do
    employee { Employee.last }
    tour     { Tour.last }
  end

  factory :service_day do
    date { Faker::Date.forward(days: 100) }
    for_tour

    trait :for_tour do
      association :workable, factory: :tour
    end

    trait :for_season do
      association :workable, factory: :season
    end
  end

  factory :venue do
    name         { Faker::Coffee.blend_name }
    street       { Faker::Address.street_address }
    city         { Faker::Address.city }
    state        { Faker::Address.state_abbr }
    zip          { Faker::Address.zip }
    country      { "United States" }
    organization { Organization.last }
  end

  factory :service_venue do
    service_day { ServiceDay.last }
    venue       { Venue.last }
  end

  factory :contact do
    organization { Organization.last }
    name         { Faker::Name.first_name }
    phone_number { "9998883322"}
    email        { "me@contact.com" }

    for_venue

    trait :for_venue do
      association :contactable, factory: :venue
    end

    trait :for_hotel do
      association :contactable, factory: :hotel
    end
  end

  factory :hotel do
  end

  factory :flight do
    airline_network   { 2 }
    airline           { 1 }
    flight_number     { Faker::Alphanumeric.alphanumeric(number: 6) }
    departure_time    { Faker::Time.forward(days: 23, period: :morning) }
    departure_airport { Faker::GreekPhilosophers.name }
    arrival_time      { Faker::Time.forward(days: 23, period: :evening) }
    arrival_airport   { Faker::GreekPhilosophers.name }
    service_day       { ServiceDay.last }
  end

  factory :passenger do
    employee { Employee.last }
    flight   { Flight.last }
    locator  { Faker::Alphanumeric.alphanumeric(number: 6) }
  end
end


# def user_with_posts(posts_count: 5)
# FactoryBot.create(:user) do |user|
#   FactoryBot.create_list(:post, posts_count, user: user)
# end
#   FactoryBot.define do
#   factory :ticket do
#     association :image1, factory: :image
#     association :image2, factory: :image
#   end
# end
# end
