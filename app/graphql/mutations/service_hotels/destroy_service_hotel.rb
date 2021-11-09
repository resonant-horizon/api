module Mutations
  module ServiceHotels
    class DestroyServiceHotel < ::Mutations::BaseMutation
      argument :id, Integer, required: true

      type Types::ServiceHotelType

      def resolve(id:)
        ServiceHotel.find(id).destroy
      end
    end
  end
end
