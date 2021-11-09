module Mutations
  module EventEmployees
    class DestroyEventEmployee < ::Mutations::BaseMutation
      argument :id, Integer, required: true

      type Types::EventEmployeeType

      def resolve(id:)
        EventEmployee.find(id).destroy
      end
    end
  end
end
