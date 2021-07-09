class EmployeeRole < ApplicationRecord
  belongs_to :employee
  belongs_to :role

  validates_presence_of :employee_id, :role_id
end
