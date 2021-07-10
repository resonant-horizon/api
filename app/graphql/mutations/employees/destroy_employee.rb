module Mutations
  module Employees
    class DestroyEmployee < ::Mutations::BaseMutation
      argument :id, Integer, required: true

      type Types::EmployeeType

      def resolve(id:)
        Employee.find(id).destroy
      end
    end
  end
end
