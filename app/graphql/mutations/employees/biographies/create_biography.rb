module Mutations
  module Employees
    module Biographies
      class CreateBiography < ::Mutations::BaseMutation
        argument :employee_id,        ID,      required: true
        argument :first_name,          String, required: true
        argument :last_name,           String, required: true
        argument :full_legal_name,      String, required: true
        argument :phone_number,        String, required: true
        argument :email,              String, required: true
        argument :street,             String, required: true
        argument :city,               String, required: true
        argument :state,              String, required: true
        argument :zip,                String, required: true
        argument :ssn,                String, required: true

        type Types::BiographyType

        def resolve(**attributes)
          Biography.create!(attributes)
        end
      end
    end
  end
end
