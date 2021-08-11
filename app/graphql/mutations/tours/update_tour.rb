module Mutations
  module Tours
    class UpdateTour < ::Mutations::BaseMutation
      argument :id,               ID,                          required: true
      argument :name,             String,                      required: false
      argument :description,      String,                      required: false
      argument :start_date,       GraphQL::Types::ISO8601Date, required: false
      argument :end_date,         GraphQL::Types::ISO8601Date, required: false
      argument :is_archived,      Boolean,                     required: false
      argument :is_international, Boolean,                     required: false

      type Types::TourType

      def resolve(id:, **attributes)
        Tour.find(id).tap do |tour|
          tour.update!(attributes)
        end
      end
    end
  end
end
