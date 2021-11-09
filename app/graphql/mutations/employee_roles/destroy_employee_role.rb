module Mutations
  module EmployeeRoles
    class DestroyEmployeeRole < ::Mutations::BaseMutation
      argument :id, Integer, required: true

      type Types::EmployeeRoleType

      def resolve(id:)
        EmployeeRole.find(id).destroy
      end
    end
  end
end
