module Mutations
  module ServiceHotels
    class CreateServiceHotel < ::Mutations::BaseMutation
      argument :hotel_id,           ID,     required: true
      argument :service_day_id,     ID,     required: true

      type Types::ServiceHotelType

      def resolve(**attributes)
        ServiceHotel.create!(attributes)
      end
    end
  end
end
