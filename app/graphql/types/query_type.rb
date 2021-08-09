module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :users, [Types::UserType], null: false do
      description 'Find all users'
    end

    field :user, Types::UserType, null: false do
      description 'Find user by ID'
      argument :id, ID, required: true
    end

    field :user_organizations, [Types::OrganizationType], null: false do
      description 'Find all organizations for a user'
      argument :user_id, ID, required: true
    end

    field :organization, Types::OrganizationType, null: false do
      description 'Find organization by ID'
      argument :id, ID, required: true
    end

    field :organizations, [Types::OrganizationType], null: false do
      description 'Find all organizations'
    end

    field :employee, Types::EmployeeType, null: false do
      description 'Find an employee by ID'
      argument :id, ID, required: true
    end

    field :roles, [Types::RoleType], null: false do
      description 'Find all roles'
    end

    field :season, Types::SeasonType, null: false do
      description 'Find a season by ID'
      argument :id, ID, required: true
    end

    field :tour, Types::TourType, null: false do
      description 'Find a tour by ID'
      argument :id, ID, required: true
    end

    field :venue, Types::VenueType, null: false do
      description 'Find a venue by ID'
      argument :id, ID, required: true
    end

    field :service_day, Types::ServiceDayType, null: false do
      description 'Find a service day by ID'
      argument :id, ID, required: true
    end

    field :event, Types::EventType, null: false do
      description 'Find an event by ID'
      argument :id, ID, required: true
    end

    field :hotel, Types::HotelType, null: false do
      description 'Find a hotel by ID'
      argument :id, ID, required: true
    end

    def user(id:)
      User.find(id)
    end

    def users
      User.all
    end

    def organization(id:)
      Organization.find(id)
    end

    def organizations
      Organization.all
    end

    def roles
      Role.all
    end

    def employee(id:)
      Employee.find(id)
    end

    def season(id:)
      Season.find(id)
    end

    def tour(id:)
      Tour.find(id)
    end

    def venue(id:)
      Venue.find(id)
    end

    def service_day(id:)
      ServiceDay.find(id)
    end

    def event(id:)
      Event.find(id)
    end

    def hotel(id:)
      Hotel.find(id)
    end
  end
end
