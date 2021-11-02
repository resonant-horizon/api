module Mutations
  module Flights
    class CreateFlight < ::Mutations::BaseMutation
      argument :service_day_id, ID, required: true

      argument :airline_network, Integer, required: true
      argument :airline, Integer, required: true
      argument :flight_number, String, required: true
      argument :is_international, Boolean, required: false

      argument :departure_time, GraphQL::Types::ISO8601DateTime, required: true
      argument :departure_airport, String, required: true
      argument :arrival_time, GraphQL::Types::ISO8601DateTime, required: false
      argument :arrival_airport, String, required: true

      type Types::FlightType

      def resolve(**attributes)
        Flight.create!(attributes)
      end
    end
  end
end
