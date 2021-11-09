module Mutations
  module Passengers
    class DestroyPassenger < ::Mutations::BaseMutation
      argument :id, Integer, required: true

      type Types::PassengerType

      def resolve(id:)
        Passenger.find(id).destroy
      end
    end
  end
end
