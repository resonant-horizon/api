class Employee < ApplicationRecord
  belongs_to :organization
  belongs_to :user

  validates_presence_of :first_name,
                        :last_name,
                        :phone_number,
                        :email,
                        :full_legal_name,
                        :street,
                        :city,
                        :state,
                        :zip,
                        :ssn,
                        :union_designee,
                        :employment_status,
                        :user_id,
                        :organization_id

  enum employment_status: [:full_time, :part_time, :contract]
  enum passport_sex: [:male, :female, :other]
end
