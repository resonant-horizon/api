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
      description 'Find organization by ID'
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

    def user_organizations(user_id:)
      Organization.find_by_user(user_id)
    end

    def organizations
      Organization.all
    end
  end
end
