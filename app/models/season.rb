class Season < ApplicationRecord
  belongs_to :organization
  has_many :service_days, as: :workable
  has_many :season_employees
  has_many :employees, through: :season_employees
  has_many :venues, through: :service_days
  has_many :hotels, through: :service_days
  has_many :contacts, through: :venues

  validates_presence_of :name,
                        :start_date,
                        :end_date,
                        :organization_id
end
