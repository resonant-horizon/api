module Types
  class BiographyType < Types::BaseObject
    field :employee, Types::EmployeeType, null: false

    field :id, ID, null: false
    field :first_name, String, null: false
    field :last_name, String, null: false
    field :full_legal_name, String, null: false
    field :phone_number, String, null: false
    field :email, String, null: false
    field :street, String, null: false
    field :city, String, null: false
    field :state, String, null: false
    field :zip, String, null: false
    field :ssn, String, null: false

    def employee
      Loaders::BelongsToLoader.for(Employee).load(object.employee_id)
    end
  end
end
