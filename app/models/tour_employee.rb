class TourEmployee < ApplicationRecord
  belongs_to :employee
  belongs_to :tour

  validates_presence_of :tour_id, :employee_id
end
