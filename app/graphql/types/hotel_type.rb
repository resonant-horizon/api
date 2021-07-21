module Types
  class HotelType < Types::BaseObject
    # field :contacts

    field :id, ID, null: false
    field :name, String, null: false
    field :street, String, null: false
    field :city, String, null: false
    field :state, String, null: false
    field :zip, String, null: false
    field :country, String, null: false
    field :notes, String, null: true

    # def organization
    #   Loaders::BelongsToLoader.for(Organization).load(object.organization_id)
    # end
    #
    # def employees
    #   Loaders::AssociationLoader.for(object.class, :employees).load(object)
    # end
  end
end