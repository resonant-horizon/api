module Types
  class EmployeeType < Types::BaseObject
    field :user, Types::UserType, null: false
    field :organization, Types::OrganizationType, null: false
    field :passport, Types::PassportType, null: true
    field :biography, Types::BiographyType, null: true
    field :traveler, Types::TravelerType, null: true
    field :roles, [Types::RoleType], null: true

    field :id, ID, null: false
    field :employment_status, String, null: false
    field :instrument_section, String, null: false
    field :substitute, Boolean, null: false
    field :union_designee, Boolean, null: false
    field :archived, Boolean, null: false

    def user
      Loaders::BelongsToLoader.for(User).load(object.user_id)
    end

    def organization
      Loaders::BelongsToLoader.for(Organization).load(object.organization_id)
    end

    def roles
      Loaders::AssociationLoader.for(object.class, :roles).load(object)
    end
  end
end
