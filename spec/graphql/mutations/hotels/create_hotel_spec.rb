require 'rails_helper'

module Mutations
  module Hotels
    RSpec.describe CreateHotel, type: :request do
      describe '.resolve' do
        it 'creates a hotel' do
          user = create(:user)
          user2 = create(:user)
          organization = create(:organization, user: user)

          expect do
            post '/graphql', params:
              { query: g_query(organization_id: organization.id)
              }
          end.to change { Hotel.count }.by(1)
        end

        it 'returns a hotel' do
          user = create(:user)
          user2 = create(:user)
          organization = create(:organization, user: user)

          post '/graphql', params: { query: g_query(organization_id: organization.id) }

          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:createHotel]

          expect(data).to include(
            id: "#{Hotel.first.id}",
            organization: { "id": organization.id.to_s },
            name: Hotel.first.name,
            street: Hotel.first.street,
            city: Hotel.first.city,
            state: Hotel.first.state,
            zip: Hotel.first.zip,
            country: Hotel.first.country,
            notes: Hotel.first.notes
          )
        end

        def g_query(organization_id:)
          <<~GQL
            mutation {
              createHotel( input: {
                organizationId: "#{organization_id}"
                name: "My Favorite Hotel"
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
                notes
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

          post '/graphql', params: { query: g_query(user_id: user2.id, organization_id: organization.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          expect(json).to have_key(:errors)
        end

        def g_query(organization_id:)
          <<~GQL
            mutation {
              createHotel( input: {
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
