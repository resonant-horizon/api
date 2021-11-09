module Mutations
  module Passengers
    class CreatePassenger < ::Mutations::BaseMutation
      argument :employee_id,        ID,     required: true
      argument :flight_id,          ID,     required: true
      argument :locator,            String, required: true

      type Types::PassengerType

      def resolve(**attributes)
        Passenger.create!(attributes)
      end
    end
  end
end
