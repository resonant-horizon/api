class Employee < ApplicationRecord
  belongs_to :organization
  belongs_to :user

  has_one :passport, dependent: :destroy
  has_one :biography, dependent: :destroy
  has_one :traveler, dependent: :destroy

  has_many :season_employees
  has_many :seasons, through: :season_employees

  has_many :tour_employees
  has_many :tours, through: :tour_employees

  has_many :employee_roles, dependent: :destroy
  has_many :roles, through: :employee_roles

  has_many :service_employees
  has_many :service_days, through: :service_employees

  has_many :event_employees
  has_many :events, through: :event_employees

  has_many :passengers
  has_many :flights, through: :passengers

  validates_presence_of :employment_status,
                        :user_id,
                        :organization_id,
                        :instrument_section

  enum employment_status: {
    full_time: 0,
    part_time: 1,
    contract: 2
  }, _prefix: true
  enum instrument_section: {
    soprano: 1,
    alto: 2,
    tenor: 3,
    bass: 4,
    conductor: 5,
    composer: 6,
    piccolo: 7,
    flute: 8,
    alto_flute: 9,
    clarinet: 10,
    eb_clarinet: 11,
    bass_clarinet: 12,
    alto_clarinet: 13,
    oboe: 14,
    english_horn: 15,
    bassoon: 16,
    contrabassoon: 17,
    horn: 18,
    soprano_sax: 19,
    alto_sax: 20,
    tenor_sax: 21,
    bari_sax: 22,
    saxophone: 23,
    trumpet: 24,
    cornet: 25,
    flugelhorn: 26,
    tenor_trombone: 27,
    bass_trombone: 28,
    euphonium: 29,
    wagner_tuba: 30,
    tuba: 31,
    first_violin: 32,
    second_violin: 33,
    viola: 34,
    cello: 35,
    contrabass: 36,
    percussion: 37,
    piano: 38,
    harp: 39,
    harpsichord: 40,
    nonmusician: 41,
  }, _prefix: true
end
