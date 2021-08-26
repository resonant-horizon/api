module Mutations
  module ServiceDays
    class CreateServiceDay < ::Mutations::BaseMutation
      argument :workable_id,         ID,      required: true
      argument :workable_type,       String,  required: true
      argument :name,                String,  required: false
      argument :description,         String,  required: false
      argument :date,                GraphQL::Types::ISO8601Date, required: true
      argument :has_travel,          Boolean, required: false
      argument :has_rehearsal,       Boolean, required: false
      argument :has_concert,         Boolean, required: false
      argument :has_loadin,          Boolean, required: false
      argument :has_loadout,         Boolean, required: false

      type Types::ServiceDayType

      def resolve(workable_id:, workable_type:, **attributes)
        if workable_type == "Season"
          Season.find(workable_id).service_days.create!(attributes)
        elsif workable_type == "Tour"
          Tour.find(workable_id).service_days.create!(attributes)
        else
          raise GraphQL::ExecutionError, "Type not valid"
        end
      end

      def workable_type
        self.constantize
      end
    end
  end
end
