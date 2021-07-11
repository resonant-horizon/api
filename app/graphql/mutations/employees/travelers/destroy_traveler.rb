module Mutations
  module Employees
    module Travelers
      class DestroyTraveler < ::Mutations::BaseMutation
        argument :id, ID, required: true

        type Types::TravelerType

        def resolve(id:)
          Traveler.find(id).destroy
        end
      end
    end
  end
end
