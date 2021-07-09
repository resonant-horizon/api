class Biography < ApplicationRecord
  belongs_to :employee

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
                        :employee_id
end
