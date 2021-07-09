module Types
  class RoleType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :description, String, null: true
    field :employees, [Types::EmployeeType], null: true

    # def employees
    #   Loaders::HasManyLoader.for(Roles).load(object.id)
    # end
  end
end
