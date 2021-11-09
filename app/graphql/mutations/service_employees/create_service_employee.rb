module Mutations
  module ServiceEmployees
    class CreateServiceEmployee < ::Mutations::BaseMutation
      argument :employee_id, ID,     required: true
      argument :service_day_id,    ID,     required: true

      type Types::ServiceEmployeeType

      def resolve(**attributes)
        ServiceEmployee.create!(attributes)
      end
    end
  end
end
