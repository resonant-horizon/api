class EventEmployee < ApplicationRecord
  belongs_to :employee
  belongs_to :event

  validates_presence_of :employee_id, :event_id
end
