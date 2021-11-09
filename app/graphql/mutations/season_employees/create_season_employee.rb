module Mutations
  module SeasonEmployees
    class CreateSeasonEmployee < ::Mutations::BaseMutation
      argument :employee_id, ID,     required: true
      argument :season_id,    ID,     required: true

      type Types::SeasonEmployeeType

      def resolve(**attributes)
        SeasonEmployee.create!(attributes)
      end
    end
  end
end
