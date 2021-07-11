module Mutations
  module Employees
    module Biographies
      class UpdateBiography < ::Mutations::BaseMutation
        argument :id, ID, required: true
        argument :employee_id, ID, required: false
        
        argument :first_name,          String, required: false
        argument :last_name,           String, required: false
        argument :full_legal_name,      String, required: false
        argument :phone_number,        String, required: false
        argument :email,              String, required: false
        argument :street,             String, required: false
        argument :city,               String, required: false
        argument :state,              String, required: false
        argument :zip,                String, required: false
        argument :ssn,                String, required: false

        type Types::BiographyType

        def resolve(id:, **attributes)
        Biography.find(id).tap do |bio|
          bio.update!(attributes)
          end
        end
      end
    end
  end
end
