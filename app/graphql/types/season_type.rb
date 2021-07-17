module Types
  class SeasonType < Types::BaseObject
    field :organization, Types::OrganizationType, null: false
    # field :employees, [Types::EmployeeType], null: true
    
    field :id, ID, null: false
    field :name, String, null: false
    field :description, String, null: true
    field :is_archived, Boolean, null: false
    field :start_date, GraphQL::Types::ISO8601Date, null: false
    field :end_date, GraphQL::Types::ISO8601Date, null: false

    def organization
      Loaders::BelongsToLoader.for(Organization).load(object.organization_id)
    end

    # def employees
    #   Loaders::HasManyLoader.for(Employee, :season_id).load(object.id)
    # end
  end
end
