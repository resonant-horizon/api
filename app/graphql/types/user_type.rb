module Types
  class UserType < Types::BaseObject
    field :organizations, [Types::OrganizationType], null: true

    field :id, ID, null: false

    field :first_name, String, null: false
    field :last_name, String, null: false
    field :phone_number, String, null: false
    field :email, String, null: false

    def organizations
      Loaders::HasManyLoader.for(Organization, :user_id).load(object.id)
    end
  end
end
