class Hotel < ApplicationRecord
  belongs_to :organization
  has_many :contacts, as: :contactable
  has_many :service_hotels
  has_many :service_days, through: :service_hotels
  has_many :tours, through: :service_days, source: :workable, source_type: "Tour"
  has_many :seasons, through: :service_days, source: :workable, source_type: "Season"
  has_many :rooms

  validates_presence_of :name,
                        :street,
                        :city,
                        :state,
                        :zip,
                        :country
end
