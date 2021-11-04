module Mutations
  module Venues
    class CreateVenue < ::Mutations::BaseMutation
      argument :organization_id,     ID,      required: true
      argument :name,                String,  required: true
      argument :street,              String,  required: true
      argument :city,                String,  required: true
      argument :state,               String,  required: true
      argument :zip,                 String,  required: true
      argument :country,             String,  required: true
      argument :capacity,            String,  required: false
      argument :is_headquarters,     Boolean, required: false

      type Types::VenueType

      def resolve(organization_id:, **attributes)
        Organization.find(organization_id).venues.create!(attributes)
      end
    end
  end
end
