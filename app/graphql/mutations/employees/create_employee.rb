module Mutations
  module Employees
    class CreateEmployee < ::Mutations::BaseMutation
      argument :user_id,            ID,      required: true
      argument :organization_id,    ID,      required: true
      argument :instrument_section, String,  required: true
      argument :employment_status,  String,  required: true
      argument :substitute,         Boolean, required: false
      argument :union_designee,     Boolean, required: false
      argument :archived,           Boolean, required: false

      type Types::EmployeeType

      def resolve(organization_id:, **attributes)
        Organization.find(organization_id).employees.create!(attributes)
      end
    end
  end
end
