require 'rails_helper'

module Mutations
  module Venues
    RSpec.describe CreateVenue, type: :request do
      describe '.resolve' do
        it 'creates a venue' do
          user = create(:user)
          user2 = create(:user)
          organization = create(:organization, user: user)

          expect do
            post '/graphql', params:
              { query: g_query(organization_id: organization.id)
              }
          end.to change { Venue.count }.by(1)
        end

        it 'returns a venue' do
          user = create(:user)
          user2 = create(:user)
          organization = create(:organization, user: user)

          post '/graphql', params: { query: g_query(organization_id: organization.id) }

          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:createVenue]

          expect(data).to include(
            id: "#{Venue.first.id}",
            organization: { "id": organization.id.to_s },
            name: Venue.first.name,
            street: Venue.first.street,
            city: Venue.first.city,
            state: Venue.first.state,
            zip: Venue.first.zip,
            country: Venue.first.country,
            capacity: Venue.first.capacity,
            isHeadquarters: Venue.first.is_headquarters
          )
        end

        def g_query(organization_id:)
          <<~GQL
            mutation {
              createVenue( input: {
                organizationId: "#{organization_id}"
                name: "My Favorite Venue"
                street: "Main Street"
                city: "Chester"
                state: "WV"
                zip: "78965"
                country: "USA"
              } ){
                id
                name
                street
                city
                state
                zip
                country
                capacity
                isHeadquarters
                organization {
                  id
                }
              }
            }
          GQL
        end
      end

      describe 'sad path' do
        it 'returns errors' do
          user = create(:user)
          user2 = create(:user)
          organization = create(:organization, user: user)

          post '/graphql', params: { query: g_query(organization_id: organization.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          expect(json).to have_key(:errors)
        end

        def g_query(organization_id:)
          <<~GQL
            mutation {
              createVenue( input: {
                organizationId: #{organization_id}
              } ){
                id
              }
            }
          GQL
        end
      end
    end
  end
end
