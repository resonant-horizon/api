module Mutations
  module Employees
    module Travelers
      class CreateTraveler < ::Mutations::BaseMutation
        argument :employee_id,      ID,     required: true
        argument :delta_ff,         String, required: false
        argument :american_ff,      String, required: false
        argument :united_ff,        String, required: false
        argument :lufthansa_ff,     String, required: false
        argument :britishAir_ff,    String, required: false
        argument :seat_preference,  String, required: true

        type Types::TravelerType

        def resolve(**attributes)
          Traveler.create!(attributes)
        end
      end
    end
  end
end
