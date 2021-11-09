module Mutations
  module EventEmployees
    class CreateEventEmployee < ::Mutations::BaseMutation
      argument :employee_id, ID,     required: true
      argument :event_id,    ID,     required: true

      type Types::EventEmployeeType

      def resolve(**attributes)
        EventEmployee.create!(attributes)
      end
    end
  end
end
