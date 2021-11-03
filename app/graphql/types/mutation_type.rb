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
      description 'Create an employee biography'
    end

    field :update_biography, mutation: Mutations::Employees::Biographies::UpdateBiography do
      description 'Update an employee biography'
    end

    field :destroy_biography, mutation: Mutations::Employees::Biographies::DestroyBiography do
      description 'Destroy an employee biography'
    end

    field :create_passport, mutation: Mutations::Employees::Passports::CreatePassport do
      description 'Create an employee passport'
    end

    field :update_passport, mutation: Mutations::Employees::Passports::UpdatePassport do
      description 'Update an employee passport'
    end

    field :destroy_passport, mutation: Mutations::Employees::Passports::DestroyPassport do
      description 'Destroy an employee passport'
    end

    field :create_traveler, mutation: Mutations::Employees::Travelers::CreateTraveler do
      description 'Create an employee traveler'
    end

    field :update_traveler, mutation: Mutations::Employees::Travelers::UpdateTraveler do
      description 'Update an employee traveler'
    end

    field :destroy_traveler, mutation: Mutations::Employees::Travelers::DestroyTraveler do
      description 'Destroy an employee traveler'
    end

    field :create_tour, mutation: Mutations::Tours::CreateTour do
      description 'Create a tour'
    end

    field :update_tour, mutation: Mutations::Tours::UpdateTour do
      description 'Update a tour'
    end

    field :destroy_tour, mutation: Mutations::Tours::DestroyTour do
      description 'Destroy a tour'
    end

    field :create_season, mutation: Mutations::Seasons::CreateSeason do
      description 'Create a season'
    end

    field :update_season, mutation: Mutations::Seasons::UpdateSeason do
      description 'Update a season'
    end

    field :destroy_season, mutation: Mutations::Seasons::DestroySeason do
      description 'Destroy a season'
    end

    field :create_service_day, mutation: Mutations::ServiceDays::CreateServiceDay do
      description 'Create a service day'
    end

    field :destroy_service_day, mutation: Mutations::ServiceDays::DestroyServiceDay do
      description 'Destroy a service day'
    end

    field :update_service_day, mutation: Mutations::ServiceDays::UpdateServiceDay do
      description 'Update a service day'
    end

    field :create_event, mutation: Mutations::Events::CreateEvent do
      description 'Create an event'
    end

    field :destroy_event, mutation: Mutations::Events::DestroyEvent do
      description 'Destroy an event'
    end

    field :update_event, mutation: Mutations::Events::UpdateEvent do
      description 'Update an event'
    end

    field :create_flight, mutation: Mutations::Flights::CreateFlight do
      description 'Create a flight'
    end

    field :destroy_flight, mutation: Mutations::Flights::DestroyFlight do
      description 'Destroy a flight'
    end

    field :update_flight, mutation: Mutations::Flights::UpdateFlight do
      description 'Update a flight'
    end

    field :create_hotel, mutation: Mutations::Hotels::CreateHotel do
      description 'Create a hotel'
    end

    field :destroy_hotel, mutation: Mutations::Hotels::DestroyHotel do
      description 'Destroy a hotel'
    end

    field :update_hotel, mutation: Mutations::Hotels::UpdateHotel do
      description 'Update a hotel'
    end
  end
end
