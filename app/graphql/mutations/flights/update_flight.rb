module Mutations
  module Flights
    class UpdateFlight < ::Mutations::BaseMutation

      argument :id,             ID,     required: true
      argument :service_day_id, ID, required: false

      argument :airline_network,  Integer, required: false
      argument :airline,          Integer, required: false
      argument :flight_number,    String, required: false
      argument :is_international, Boolean, required: false

      argument :departure_time, GraphQL::Types::ISO8601DateTime, required: false
      argument :departure_airport,  String, required: false
      argument :arrival_time,   GraphQL::Types::ISO8601DateTime, required: false
      argument :arrival_airport,    String, required: false

      type Types::FlightType

      def resolve(id:, **attributes)
        Flight.find(id).tap do |flight|
          flight.update!(attributes)
        end
      end
    end
  end
end
