module Types
  class ServiceDayType < Types::BaseObject
    field :employees, [Types::EmployeeType], null: true
    field :venues, [Types::VenueType], null: true
    field :flights, [Types::FlightType], null: true
    field :hotels, [Types::HotelType], null: true
    field :contacts, [Types::ContactType], null: true
    field :events, [Types::EventType], null: true

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

    def employees
      Loaders::AssociationLoader.for(object.class, :employees).load(object)
    end

    def venues
      Loaders::AssociationLoader.for(object.class, :venues).load(object)
    end

    def flights
      Loaders::AssociationLoader.for(object.class, :flights).load(object)
    end

    def hotels
      Loaders::AssociationLoader.for(object.class, :hotels).load(object)
    end

    def contacts
      Loaders::AssociationLoader.for(object.class, :contacts).load(object)
    end
  end
end
