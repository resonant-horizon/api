class User < ApplicationRecord
  has_many :employees
  has_many :organizations, through: :employees

  validates_presence_of :first_name,
                        :last_name,
                        :phone_number,
                        :email
end
