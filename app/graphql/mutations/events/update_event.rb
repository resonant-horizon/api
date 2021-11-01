module Mutations
  module Events
    class UpdateEvent < ::Mutations::BaseMutation

      argument :id,          ID,     required: true
      argument :name,        String, required: false
      argument :description, String, required: false
      argument :start_time,  GraphQL::Types::ISO8601DateTime, required: false
      argument :end_time,    GraphQL::Types::ISO8601DateTime, required: false
      argument :notes,       String, required: false
      argument :location,    String, required: false

      type Types::EventType

      def resolve(id:, **attributes)
        Event.find(id).tap do |event|
          event.update!(attributes)
        end
      end
    end
  end
end
