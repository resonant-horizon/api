module Types
  class FlightType < Types::BaseObject
    # field :contacts
    field :service_day, Types::ServiceDayType, null: false
    field :passengers, [Types::PassengerType], null: false

    field :id, ID, null: false
    field :airline_network, String, null: false
    field :airline, String, null: false
    field :flight_number, String, null: false
    field :departure_time, GraphQL::Types::ISO8601DateTime, null: false
    field :departure_airport, String, null: false
    field :arrival_time, GraphQL::Types::ISO8601DateTime, null: false
    field :arrival_airport, String, null: false
    field :is_international, Boolean, null: false

    def service_day
      Loaders::BelongsToLoader.for(ServiceDay).load(object.service_day_id)
    end

    def passengers
      Loaders::AssociationLoader.for(object.class, :passengers).load(object)
    end
  end
end
