class ServiceDay < ApplicationRecord
  belongs_to :workable, polymorphic: true
  has_many :service_venues
  has_many :venues, through: :service_venues
  has_many :contacts, through: :venues
  has_many :service_hotels
  has_many :hotels, through: :service_hotels
  has_many :service_employees
  has_many :employees, through: :service_employees
  has_many :events
  has_many :flights

  validates_presence_of :name,
                        :date,
                        :description,
                        :has_travel,
                        :workable_id,
                        :has_rehearsal,
                        :has_concert,
                        :has_loadin,
                        :has_loadout,
                        :has_travel
end
