class Organization < ApplicationRecord
  belongs_to :user
  has_many :employees
  has_many :tours
  has_many :seasons

  validates_presence_of :name,
                        :contact_name,
                        :contact_email,
                        :phone_number,
                        :street_address,
                        :city,
                        :state,
                        :zip,
                        :user_id
end
