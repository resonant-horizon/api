class Flight < ApplicationRecord
  belongs_to :service_day
  has_many :passengers
  has_many :employees, through: :passengers

  validates_presence_of :airline_network,
                        :airline,
                        :flight_number,
                        :departure_time,
                        :departure_airport,
                        :arrival_time,
                        :arrival_airport,
                        :service_day_id

  enum airline_network: {
    star_alliance: 0,
    sky_team: 1,
    one_world: 2,
    other_network: 3
  }

  enum airline: {
    american: 0,
    united: 1,
    delta: 2,
    lufthansa: 3,
    alaska: 4,
    hawaiian: 5,
    southwest: 6,
    jetblue: 7,
    air_canada: 8,
    aeromexico: 9,
    virgin_atlantic: 10,
    air_new_zealand: 11,
    british_airways: 12,
    all_nippon: 13,
    air_japan: 14,
    cathay_pacific: 15,
    qatar_airways: 16,
    emirates: 17,
    korean_air: 18,
    other_airline: 19
  }
end
