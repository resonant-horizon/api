module Mutations
  module ServiceDays
    class DestroyServiceDay < ::Mutations::BaseMutation
      argument :id, Integer, required: true

      type Types::ServiceDayType

      def resolve(id:)
        ServiceDay.find(id).destroy
      end
    end
  end
end
