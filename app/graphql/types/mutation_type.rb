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

    field :update_employee, mutation: Mutations::Employees::UpdateEmployee do
      description 'Update an employee'
    end

    field :destroy_employee, mutation: Mutations::Employees::DestroyEmployee do
      description 'Destroy an employee'
    end

    field :create_biography, mutation: Mutations::Employees::Biographies::CreateBiography do
      description 'Create a biography belonging to an employee'
    end

    # field :update_biography, mutation: Mutations::Employees::Biographies::UpdateBiography do
    #   description 'Update a biography'
    # end

    # field :destroy_biography, mutation: Mutations::Employees::Biographies::DestroyBiography do
    #   description 'Destroy a biography'
    # end

    field :create_passport, mutation: Mutations::Employees::Passports::CreatePassport do
      description 'Create a passport belonging to an employee'
    end

    # field :update_passport, mutation: Mutations::Employees::Passports::UpdatePassport do
    #   description 'Update a passport'
    # end

    # field :destroy_passport, mutation: Mutations::Employees::Passports::DestroyPassport do
    #   description 'Destroy a passport'
    # end

    field :create_traveler, mutation: Mutations::Employees::Travelers::CreateTraveler do
      description 'Create a traveler belonging to an employee'
    end

    # field :update_traveler, mutation: Mutations::Employees::Travelers::UpdateTraveler do
    #   description 'Update a traveler'
    # end

    # field :destroy_traveler, mutation: Mutations::Employees::Travelers::DestroyTraveler do
    #   description 'Destroy a traveler'
    # end
  end
end
