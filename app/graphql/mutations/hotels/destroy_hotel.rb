module Mutations
  module Hotels
    class DestroyHotel < ::Mutations::BaseMutation
      argument :id, Integer, required: true

      type Types::HotelType

      def resolve(id:)
        Hotel.find(id).destroy
      end
    end
  end
end
