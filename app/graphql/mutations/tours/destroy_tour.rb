module Mutations
  module Tours
    class DestroyTour < ::Mutations::BaseMutation
      argument :id, Integer, required: true

      type Types::TourType

      def resolve(id:)
        Tour.find(id).destroy
      end
    end
  end
end
