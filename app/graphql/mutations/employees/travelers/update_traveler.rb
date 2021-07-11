module Mutations
  module Employees
    module Travelers
      class UpdateTraveler < ::Mutations::BaseMutation
        argument :id, ID, required: true
        argument :employee_id, ID, required: false
        argument :delta_ff,         String, required: false
        argument :american_ff,      String, required: false
        argument :united_ff,        String, required: false
        argument :lufthansa_ff,     String, required: false
        argument :british_air_ff,    String, required: false
        argument :seat_preference,  String, required: true

        type Types::TravelerType

        def resolve(id:, **attributes)
        Traveler.find(id).tap do |traveler|
          traveler.update!(attributes)
          end
        end
      end
    end
  end
end
