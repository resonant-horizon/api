module Mutations
  module Hotels
    class CreateHotel < ::Mutations::BaseMutation
      argument :organization_id,     ID,     required: true
      argument :name,                String, required: true
      argument :street,              String, required: true
      argument :city,                String, required: true
      argument :state,               String, required: true
      argument :zip,                 String, required: true
      argument :country,             String, required: true
      argument :notes,               String, required: false

      type Types::HotelType

      def resolve(organization_id:, **attributes)
        Organization.find(organization_id).hotels.create!(attributes)
      end
    end
  end
end
