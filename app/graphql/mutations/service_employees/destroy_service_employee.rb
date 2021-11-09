module Mutations
  module ServiceEmployees
    class DestroyServiceEmployee < ::Mutations::BaseMutation
      argument :id, Integer, required: true

      type Types::ServiceEmployeeType

      def resolve(id:)
        ServiceEmployee.find(id).destroy
      end
    end
  end
end
