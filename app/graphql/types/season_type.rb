module Types
  class SeasonType < Types::BaseObject
    field :organization, Types::OrganizationType, null: false
    field :employees, [Types::EmployeeType], null: true
    field :service_days, [Types::ServiceDayType], null: true
    field :venues, [Types::VenueType], null: true
    field :hotels, [Types::HotelType], null: true
    field :contacts, [Types::ContactType], null: true

    field :id, ID, null: false
    field :name, String, null: false
    field :description, String, null: true
    field :is_archived, Boolean, null: false
    field :start_date, GraphQL::Types::ISO8601Date, null: false
    field :end_date, GraphQL::Types::ISO8601Date, null: false

    def organization
      Loaders::BelongsToLoader.for(Organization).load(object.organization_id)
    end

    def employees
      Loaders::AssociationLoader.for(object.class, :employees).load(object)
    end

    def venues
      Loaders::AssociationLoader.for(object.class, :venues).load(object)
    end

    def contacts
      Loaders::AssociationLoader.for(object.class, :contacts).load(object)
    end

    def service_days
      Loaders::AssociationLoader.for(object.class, :service_days).load(object)
    end

    def hotels
      Loaders::AssociationLoader.for(object.class, :hotels).load(object)
    end
  end
end
