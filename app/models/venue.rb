class Venue < ApplicationRecord
  belongs_to :organization
  has_many :service_venues
  has_many :service_days, through: :service_venues
  has_many :contacts, as: :contactable

  validates_presence_of :name, :street, :city, :state, :zip
end
