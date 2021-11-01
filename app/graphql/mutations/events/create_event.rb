module Mutations
  module Events
    class CreateEvent < ::Mutations::BaseMutation
      argument :service_day_id, ID, required: true
      argument :description, String, required: false
      argument :name, String, required: true
      argument :start_time, GraphQL::Types::ISO8601DateTime, required: true
      argument :end_time, GraphQL::Types::ISO8601DateTime, required: false
      argument :notes, String, required: false
      argument :location, String, required: false

      type Types::EventType

      def resolve(**attributes)
        Event.create!(attributes)
      end
    end
  end
end
