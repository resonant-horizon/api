module Types
  class EmployeeType < Types::BaseObject
    field :user, Types::UserType, null: false
    field :organization, Types::OrganizationType, null: false
    field :passport, Types::PassportType, null: true
    field :biography, Types::BiographyType, null: true
    field :traveler, Types::TravelerType, null: true
    field :roles, [Types::RoleType], null: true
    field :events, [Types::EventType], null: true
    field :passengers, [Types::PassengerType], null: true
    field :service_days, [Types::ServiceDayType], null: true
    field :tours, [Types::TourType], null: true
    field :flights, [Types::FlightType], null: true
    field :seasons, [Types::SeasonType], null: true

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

    def events
      Loaders::AssociationLoader.for(object.class, :events).load(object)
    end

    def seasons
      Loaders::AssociationLoader.for(object.class, :seasons).load(object)
    end

    def service_days
      Loaders::AssociationLoader.for(object.class, :service_days).load(object)
    end

    def tours
      Loaders::AssociationLoader.for(object.class, :tours).load(object)
    end

    def passengers
      Loaders::AssociationLoader.for(object.class, :passengers).load(object)
    end

    def flights
      Loaders::AssociationLoader.for(object.class, :flights).load(object)
    end
  end
end
