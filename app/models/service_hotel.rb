class ServiceHotel < ApplicationRecord
  belongs_to :hotel
  belongs_to :service_day

  validates_presence_of :hotel_id,
                        :service_day_id
end
