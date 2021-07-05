class Traveler < ApplicationRecord
  belongs_to :employee

  validates_presence_of :seat_preference, :employee_id
end
