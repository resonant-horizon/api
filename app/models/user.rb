class User < ApplicationRecord
  has_many :organizations

  validates_presence_of :first_name, :last_name, :phone_number, :email
end
