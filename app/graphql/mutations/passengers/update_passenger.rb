module Mutations
  module Passengers
    class UpdatePassenger < ::Mutations::BaseMutation

      argument :id,          ID,     required: true
      argument :locator,     String, required: false

      type Types::PassengerType

      def resolve(id:, **attributes)
        Passenger.find(id).tap do |passenger|
          passenger.update!(attributes)
        end
      end
    end
  end
end
