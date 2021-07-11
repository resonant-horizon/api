module Mutations
  module Employees
    module Passports
      class UpdatePassport < ::Mutations::BaseMutation
        argument :id, ID, required: true
        argument :passport_number, String, required: false
        argument :surname,         String, required: false
        argument :given_names,     String, required: false
        argument :nationality,     String, required: false
        argument :birth_place,     String, required: false
        argument :birthdate,       GraphQL::Types::ISO8601Date, required: false
        argument :expiration_date, GraphQL::Types::ISO8601Date, required: false
        argument :issue_date,      GraphQL::Types::ISO8601Date, required: false
        argument :passport_sex,    String, required: false

        type Types::PassportType

        def resolve(id:, **attributes)
        Passport.find(id).tap do |pass|
          pass.update!(attributes)
          end
        end
      end
    end
  end
end
