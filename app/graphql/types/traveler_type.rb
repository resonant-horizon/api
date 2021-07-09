module Types
  class TravelerType < Types::BaseObject
    field :employee, Types::EmployeeType, null: false

    field :id, ID, null: false
    field :delta_ff, String, null: false
    field :american_ff, String, null: false
    field :united_ff, String, null: false
    field :lufthansa_ff, String, null: false
    field :british_air_ff, String, null: false
    field :seat_preference, String, null: false

    def employee
      Loaders::BelongsToLoader.for(Employee).load(object.employee_id)
    end
  end
end
