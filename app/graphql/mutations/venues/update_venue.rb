module Mutations
  module Venues
    class UpdateVenue < ::Mutations::BaseMutation
      argument :id,                 ID,     required: true
      argument :name,               String, required: false
      argument :street,             String, required: false
      argument :city,               String, required: false
      argument :state,              String, required: false
      argument :zip,                String, required: false
      argument :country,            String, required: false
      argument :capacity,           String, required: false
      argument :is_headquarters,    Boolean, required: false

      type Types::VenueType

      def resolve(id:, **attributes)
        Venue.find(id).tap do |venue|
          venue.update!(attributes)
        end
      end
    end
  end
end
