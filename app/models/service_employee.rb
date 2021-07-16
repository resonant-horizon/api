class ServiceEmployee < ApplicationRecord
  belongs_to :service_day
  belongs_to :employee

  validates_presence_of :service_day_id,
                        :employee_id
end
