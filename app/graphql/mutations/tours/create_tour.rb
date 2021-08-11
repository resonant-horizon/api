module Mutations
  module Tours
    class CreateTour < ::Mutations::BaseMutation
      argument :organization_id,     ID,      required: true
      argument :name,                String,  required: true
      argument :description,         String,  required: false
      argument :start_date,          GraphQL::Types::ISO8601Date, required: true
      argument :end_date,            GraphQL::Types::ISO8601Date, required: true
      argument :is_archived,         Boolean, required: false
      argument :is_international,    Boolean, required: false

      type Types::TourType

      def resolve(organization_id:, **attributes)
        Organization.find(organization_id).tours.create!(attributes)
      end
    end
  end
end
