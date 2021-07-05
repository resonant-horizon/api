class Employee < ApplicationRecord
  belongs_to :organization
  belongs_to :user
  has_one :passport
  has_one :biography
  has_one :frequent_flyer

  validates_presence_of :union_designee,
                        :employment_status,
                        :user_id,
                        :organization_id,
                        :role,
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
  enum role: {
    concert_manager: 0,
    stage_manager: 1,
    music_director: 2,
    associate_conductor: 3,
    assistant_conductor: 4,
    tour_manager: 5,
    production_manager: 6,
    company_manager: 7,
    librarian: 8,
    concertmaster: 9,
    principal: 10,
    vice_principal: 11,
    section: 12,
    guest_artist: 13,
    videographer: 14,
    sound_engineer: 15,
    usher: 16,
    stage_crew: 17,
    lighting: 18,
    ceo: 19,
    coo: 20,
    cfo: 21,
    cto: 22,
    development: 23
  }, _prefix: true
end
