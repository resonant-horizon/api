module Types
  class HotelType < Types::BaseObject
    field :contacts, [Types::ContactType], null: true
    field :service_days, [Types::ServiceDayType], null: true

    field :id, ID, null: false
    field :name, String, null: false
    field :street, String, null: false
    field :city, String, null: false
    field :state, String, null: false
    field :zip, String, null: false
    field :country, String, null: false
    field :notes, String, null: true

    def service_days
      Loaders::AssociationLoader.for(object.class, :service_days).load(object)
    end

    def contacts
      Loaders::AssociationLoader.for(object.class, :contacts).load(object)
    end
  end
end
