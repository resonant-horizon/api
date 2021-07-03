require 'rails_helper'

module Mutations
  module Organizations
    RSpec.describe UpdateOrganization, type: :request do
      describe 'resolve' do
        it 'updates an organization' do
          user = create(:user)
          organization = create(:organization)

          post '/graphql', params: { query: g_query(id: organization.id, user_id: user.id) }

          expect(organization.reload).to have_attributes(
            name: "Rob",
            user_id: user.id
          )
        end

        it 'returns an organization' do
          user = create(:user)
          organization = create(:organization)

          post '/graphql', params: { query: g_query(id: organization.id, user_id: user.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:updateOrganization]

          expect(data).to include(
            id: "#{ organization.reload.id }",
            name: "#{ organization.name }",
            user: { "id": user.id.to_s }
          )
        end

        def g_query(id:, user_id:)
          <<~GQL
            mutation {
              updateOrganization(input: {
                id: #{id}
                name: "Rob"
                userId: #{user_id}
              }){
                id
                name
                user {
                  id
                }
              }
            }
          GQL
        end
      end

      describe 'sad path' do
        it 'returns with errors' do
          user = create(:user)
          organization = create(:organization, user_id: user.id)

          post '/graphql', params: { query: g_query(id: organization.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          expect(json).to have_key(:errors)
        end

        def g_query(id:)
          <<~GQL
            mutation {
              updateOrganization( input: {
                id: 'not an id'
              }) {
                id
                firstName
                lastName
                email
                phoneNumber
                note
                user {
                  id
                }
              }
            }
          GQL
        end
      end
    end
  end
end
