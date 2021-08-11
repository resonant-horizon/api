module Mutations
  module Seasons
    class CreateSeason < ::Mutations::BaseMutation
      argument :organization_id,     ID,      required: true
      argument :name,                String,  required: true
      argument :description,         String,  required: false
      argument :start_date,          GraphQL::Types::ISO8601Date, required: true
      argument :end_date,            GraphQL::Types::ISO8601Date, required: true
      argument :is_archived,         Boolean, required: false

      type Types::SeasonType

      def resolve(organization_id:, **attributes)
        Organization.find(organization_id).seasons.create!(attributes)
      end
    end
  end
end
