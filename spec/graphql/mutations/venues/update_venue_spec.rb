require 'rails_helper'

module Mutations
  module Venues
    RSpec.describe UpdateVenue, type: :request do
      describe 'resolve' do
        it 'updates a venue' do
          user = create(:user)
          organization = create(:organization)
          venue = create(:venue, organization: organization)

          post '/graphql', params: { query: g_query(id: venue.id) }

          expect(venue.reload).to have_attributes(
            name: "New Name",
            organization_id: organization.id
          )
        end

        it 'returns a venue' do
          user = create(:user)
          organization = create(:organization)
          venue = create(:venue, organization: organization)

          post '/graphql', params: { query: g_query(id: venue.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:updateVenue]

          expect(data).to include(
            id: "#{ venue.reload.id }",
            name: "New Name",
            organization: { "id": organization.id.to_s }
          )
        end

        def g_query(id:)
          <<~GQL
            mutation {
              updateVenue(input: {
                id: #{id}
                name: "New Name"
              }){
                id
                name
                organization {
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
          venue = create(:venue, organization: organization)

          post '/graphql', params: { query: g_query(id: venue.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          expect(json).to have_key(:errors)
        end

        def g_query(id:)
          <<~GQL
            mutation {
              updateVenue( input: {
                id: 'not an id'
              }) {
                id
                name
                organization {
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
