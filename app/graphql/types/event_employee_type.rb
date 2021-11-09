module Types
  class EventEmployeeType < Types::BaseObject
    # field :event,     Types::EventType,     null: false
    # field :employee,  Types::EmployeeType,  null: false

    field :id,        ID,                   null: false

    # def event
    #   Loaders::BelongsToLoader.for(Event).load(object.event_id)
    # end
    #
    # def employee
    #   Loaders::BelongsToLoader.for(Employee).load(object.employee_id)
    # end
  end
end
