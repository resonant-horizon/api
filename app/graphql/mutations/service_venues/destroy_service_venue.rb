module Mutations
  module ServiceVenues
    class DestroyServiceVenue < ::Mutations::BaseMutation
      argument :id, Integer, required: true

      type Types::ServiceVenueType

      def resolve(id:)
        ServiceVenue.find(id).destroy
      end
    end
  end
end
