class Passenger < ApplicationRecord
  belongs_to :employee
  belongs_to :flight

  validates_presence_of :employee_id,
                        :flight_id,
                        :locator
  end
