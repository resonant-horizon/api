module Types
  class EmployeeType < Types::BaseObject
    field :user, Types::UserType, null: false
    field :organization, Types::OrganizationType, null: false
    # field :passport, Types::PassportType
    # field :biography, Types::BiographyType
    # field :traveler, Types::TravelerType
    field :roles, [Types::RoleType], null: false

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
      Loaders::HasManyLoader.for(Role, :name).load(object.id)
    end
    # def passport
    #   Loaders::BelongsToLoader.for(Passport).load(object.passport_id)
    # end
    #
    # def biography
    #   Loaders::BelongsToLoader.for(Biography).load(object.passport_id)
    # end
    #
    # def traveler
    #   Loaders::BelongsToLoader.for(Traveler).load(object.passport_id)
    # end
  end
end
