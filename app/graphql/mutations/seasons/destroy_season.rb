module Mutations
  module Seasons
    class DestroySeason < ::Mutations::BaseMutation
      argument :id, Integer, required: true

      type Types::SeasonType

      def resolve(id:)
        Season.find(id).destroy
      end
    end
  end
end
