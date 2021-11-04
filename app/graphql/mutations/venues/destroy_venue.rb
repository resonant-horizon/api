module Mutations
  module Venues
    class DestroyVenue < ::Mutations::BaseMutation
      argument :id, Integer, required: true

      type Types::VenueType

      def resolve(id:)
        Venue.find(id).destroy
      end
    end
  end
end
