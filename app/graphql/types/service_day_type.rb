module Types
  class ServiceDayType < Types::BaseObject
    # field :employees, [Types::EmployeeType], null: true

    field :id, ID, null: false
    field :name, String, null: true
    field :description, String, null: true
    field :has_travel, Boolean, null: false
    field :has_loadin, Boolean, null: false
    field :has_loadout, Boolean, null: false
    field :has_rehearsal, Boolean, null: false
    field :has_concert, Boolean, null: false
    field :date, GraphQL::Types::ISO8601Date, null: false

    # def organization
    #   Loaders::BelongsToLoader.for(Organization).load(object.organization_id)
    # end
    #
    # def employees
    #   Loaders::AssociationLoader.for(object.class, :employees).load(object)
    # end
  end
end