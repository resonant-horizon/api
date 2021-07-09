module Types
  class PassportType < Types::BaseObject
    field :employee, Types::EmployeeType, null: false

    field :id, ID, null: false
    field :passport_number, String, null: false
    field :surname, String, null: false
    field :given_names, String, null: false
    field :nationality, String, null: false
    field :birth_place, String, null: false
    field :birthdate, GraphQL::Types::ISO8601Date, null: false
    field :expiration_date, GraphQL::Types::ISO8601Date, null: false
    field :issue_date, GraphQL::Types::ISO8601Date, null: false
    field :passport_sex, String, null: false

    def employee
      Loaders::BelongsToLoader.for(Employee).load(object.employee_id)
    end
  end
end
