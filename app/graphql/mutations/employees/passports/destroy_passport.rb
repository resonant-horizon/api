module Mutations
  module Employees
    module Passports
      class DestroyPassport < ::Mutations::BaseMutation
        argument :id, ID, required: true

        type Types::PassportType

        def resolve(id:)
          Passport.find(id).destroy
        end
      end
    end
  end
end
