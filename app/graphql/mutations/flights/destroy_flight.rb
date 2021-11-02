module Mutations
  module Flights
    class DestroyFlight < ::Mutations::BaseMutation
      argument :id, Integer, required: true

      type Types::FlightType

      def resolve(id:)
        Flight.find(id).destroy
      end
    end
  end
end
