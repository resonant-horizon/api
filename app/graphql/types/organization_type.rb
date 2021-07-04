module Types
  class OrganizationType < Types::BaseObject
    field :user, Types::UserType, null: false

    field :id, ID, null: false
    field :name, String, null: false
    field :contact_name, String, null: false
    field :contact_email, String, null: false
    field :phone_number, String, null: false
    field :street_address, String, null: false
    field :city, String, null: false
    field :state, String, null: false
    field :zip, String, null: false

    def user
      Loaders::BelongsToLoader.for(User).load(object.user_id)
    end
  end
end
