module Mutations
  module SeasonEmployees
    class DestroySeasonEmployee < ::Mutations::BaseMutation
      argument :id, Integer, required: true

      type Types::SeasonEmployeeType

      def resolve(id:)
        SeasonEmployee.find(id).destroy
      end
    end
  end
end
