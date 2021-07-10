module Mutations
  module Employees
    module Passports
      class CreatePassport < ::Mutations::BaseMutation
        argument :employee_id,        ID,  required: true
        argument :passport_number, String, required: true
        argument :surname,         String, required: true
        argument :given_names,     String, required: true
        argument :nationality,     String, required: true
        argument :birth_place,     String, required: true
        argument :birthdate,       GraphQL::Types::ISO8601Date, required: true
        argument :expiration_date, GraphQL::Types::ISO8601Date, required: true
        argument :issue_date,      GraphQL::Types::ISO8601Date, required: true
        argument :passport_sex,    String, required: true

        type Types::PassportType

        def resolve(**attributes)
          Passport.create!(attributes)
        end
      end
    end
  end
end
