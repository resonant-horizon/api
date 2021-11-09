module Mutations
  module TourEmployees
    class DestroyTourEmployee < ::Mutations::BaseMutation
      argument :id, Integer, required: true

      type Types::TourEmployeeType

      def resolve(id:)
        TourEmployee.find(id).destroy
      end
    end
  end
end
