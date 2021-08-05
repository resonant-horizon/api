module Types
  class OrganizationType < Types::BaseObject
    field :user, Types::UserType, null: false
    field :employees, [Types::EmployeeType], null: true
    field :seasons, [Types::SeasonType], null: true
    field :tours, [Types::TourType], null: true
    field :contacts, [Types::ContactType], null: true

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

    def employees
      Loaders::HasManyLoader.for(Employee, :organization_id).load(object.id)
    end

    def contacts
      Loaders::AssociationLoader.for(object.class, :contacts).load(object)
    end
  end
end
