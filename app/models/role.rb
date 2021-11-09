class Role < ApplicationRecord
  has_many :employee_roles
  has_many :employees, through: :employee_roles

  validates_presence_of :name
  #The thing I'm trying to figure out: should roles belong to an organization or should they be above the organization. Should the organization be able to customize them?
end
