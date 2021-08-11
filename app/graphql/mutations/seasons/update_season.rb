module Mutations
  module Seasons
    class UpdateSeason < ::Mutations::BaseMutation
      argument :id,               ID,                          required: true
      argument :name,             String,                      required: false
      argument :description,      String,                      required: false
      argument :start_date,       GraphQL::Types::ISO8601Date, required: false
      argument :end_date,         GraphQL::Types::ISO8601Date, required: false
      argument :is_archived,      Boolean,                     required: false

      type Types::SeasonType

      def resolve(id:, **attributes)
        Season.find(id).tap do |season|
          season.update!(attributes)
        end
      end
    end
  end
end
