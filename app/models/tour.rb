class Tour < ApplicationRecord
  belongs_to :organization
  has_many :service_days, as: :workable
  has_many :tour_employees
  has_many :employees, through: :tour_employees
  has_many :venues, through: :service_days
  has_many :contacts, through: :venues
  has_many :hotels, through: :service_days
  has_many :flights, through: :service_days

  validates_presence_of :organization_id,
                        :name,
                        :start_date,
                        :end_date
end
