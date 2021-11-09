module Mutations
  module ServiceVenues
    class CreateServiceVenue < ::Mutations::BaseMutation
      argument :venue_id,           ID,     required: true
      argument :service_day_id,     ID,     required: true

      type Types::ServiceVenueType

      def resolve(**attributes)
        ServiceVenue.create!(attributes)
      end
    end
  end
end
