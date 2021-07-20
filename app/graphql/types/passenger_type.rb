module Types
  class PassengerType < Types::BaseObject
    # field :contacts
    field :flight, Types::FlightType, null: false
    field :employee, Types::EmployeeType, null: false

    field :id, ID, null: false

    def flight
      Loaders::BelongsToLoader.for(Flight).load(object.flight_id)
    end

    def employee
      Loaders::BelongsToLoader.for(Employee).load(object.employee_id)
    end
  end
end
