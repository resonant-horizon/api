module Mutations
  module ServiceDays
    class UpdateServiceDay < ::Mutations::BaseMutation
      argument :id,                  ID,      required: true
      argument :name,                String,  required: false
      argument :description,         String,  required: false
      argument :date,                GraphQL::Types::ISO8601Date, required: false
      argument :has_travel,          Boolean, required: false
      argument :has_rehearsal,       Boolean, required: false
      argument :has_concert,         Boolean, required: false
      argument :has_loadin,          Boolean, required: false
      argument :has_loadout,         Boolean, required: false

      type Types::ServiceDayType

      def resolve(id:, **attributes)
        ServiceDay.find(id).tap do |day|
          day.update!(attributes)
        end
      end
    end
  end
end
