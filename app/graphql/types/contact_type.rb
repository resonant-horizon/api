module Types
  class ContactType < Types::BaseObject
    # field :venue,        Types::VenueType,        null: false
    field :organization, Types::OrganizationType, null: false

    field :id,                  ID, null: false
    field :contactable_id,      ID, null: false
    field :contactable_type,    String, null:false
    field :name,                String, null: false
    field :phone_number,        String, null: false
    field :email,               String, null: false
    field :description,         String, null: true
    field :role,                String, null: true
    field :is_permanent_party,  Boolean, null: false

    # def venue
    #   # Will have to do this for hotels, too. Might have to be contactable instead or add hotel as well
    #   Loaders::AssociationLoader.for(object.class, :contactable).load(object)
    # end
  end
end
