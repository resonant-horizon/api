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

    field :roles, [Types::RoleType], null: false do
      description 'Find all roles'
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
  end
end
