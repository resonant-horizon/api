module Mutations
  module Employees
    class UpdateEmployee < ::Mutations::BaseMutation
      argument :id,      ID, required: true
      argument :user_id, ID, required: false

      argument :substitute,         Boolean, required: false
      argument :union_designee,     Boolean, required: false
      argument :archived,           Boolean, required: false
      argument :instrument_section, String,  required: false
      argument :employment_status,  String,  required: false

      type Types::EmployeeType

      def resolve(id:, **attributes)
        Employee.find(id).tap do |org|
          org.update!(attributes)
        end
      end
    end
  end
end
