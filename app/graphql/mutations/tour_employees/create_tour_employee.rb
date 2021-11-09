module Mutations
  module TourEmployees
    class CreateTourEmployee < ::Mutations::BaseMutation
      argument :employee_id, ID,     required: true
      argument :tour_id,    ID,     required: true

      type Types::TourEmployeeType

      def resolve(**attributes)
        TourEmployee.create!(attributes)
      end
    end
  end
end
