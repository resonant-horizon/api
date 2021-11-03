module Mutations
  module Hotels
    class UpdateHotel < ::Mutations::BaseMutation
      argument :id,      ID,     required: true
      argument :name,    String, required: false
      argument :street,  String, required: false
      argument :city,    String, required: false
      argument :state,   String, required: false
      argument :zip,     String, required: false
      argument :country, String, required: false
      argument :notes,   String, required: false

      type Types::HotelType

      def resolve(id:, **attributes)
        Hotel.find(id).tap do |hotel|
          hotel.update!(attributes)
        end
      end
    end
  end
end
