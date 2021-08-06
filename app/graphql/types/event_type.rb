module Types
  class EventType < Types::BaseObject
    field :service_day, Types::ServiceDayType, null: false
    field :employees, [Types::EmployeeType], null: true

    field :id, ID, null: false
    field :name, String, null: false
    field :description, String, null: true
    field :start_time, GraphQL::Types::ISO8601DateTime, null: false
    field :end_time, GraphQL::Types::ISO8601DateTime, null: true
    field :notes, String, null: true
    field :location, String, null: true

    # def organization
    #   Loaders::BelongsToLoader.for(Organization).load(object.organization_id)
    # end
    #
    # def employees
    #   Loaders::AssociationLoader.for(object.class, :employees).load(object)
    # end
  end
end
