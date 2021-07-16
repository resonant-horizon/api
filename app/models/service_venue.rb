class ServiceVenue < ApplicationRecord
  belongs_to :service_day
  belongs_to :venue

  validates_presence_of :service_day_id, :venue_id
end
