class Event < ApplicationRecord
  belongs_to :service_day
  has_many :event_employees
  has_many :employees, through: :event_employees

  validates_presence_of :name,
                        :start_time,
                        :location,
                        :service_day_id
end
