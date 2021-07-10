module Types
  class MutationType < Types::BaseObject
    field :create_organization, mutation: Mutations::Organizations::CreateOrganization do
      description 'Create an organization belonging to a user'
    end

    field :update_organization, mutation: Mutations::Organizations::UpdateOrganization do
      description 'Update an organization'
    end

    field :destroy_organization, mutation: Mutations::Organizations::DestroyOrganization do
      description 'Destroy an organization'
    end

    field :create_employee, mutation: Mutations::Employees::CreateEmployee do
      description 'Create an employee belonging to a user'
    end

    # field :update_employee, mutation: Mutations::Employees::UpdateEmployee do
    #   description 'Update an employee'
    # end
    #
    # field :destroy_employee, mutation: Mutations::Employees::DestroyEmployee do
    #   description 'Destroy an employee'
    # end
  end
end
