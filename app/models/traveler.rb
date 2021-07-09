class Traveler < ApplicationRecord
  belongs_to :employee

  validates_presence_of :seat_preference, :employee_id

  enum seat_preference: {
    window: 0,
    aisle: 1,
    middle: 2
  }, _prefix: true
end
