module Mutations
  module EmployeeRoles
    class CreateEmployeeRole < ::Mutations::BaseMutation
      argument :employee_id,    ID,     required: true
      argument :role_id,        ID,     required: true

      type Types::EmployeeRoleType

      def resolve(**attributes)
        EmployeeRole.create!(attributes)
      end
    end
  end
end
