require 'rails_helper'

module Mutations
  module Hotels
    RSpec.describe UpdateHotel, type: :request do
      describe 'resolve' do
        it 'updates a hotel' do
          user = create(:user)
          organization = create(:organization)
          hotel = create(:hotel, organization: organization)

          post '/graphql', params: { query: g_query(id: hotel.id) }

          expect(hotel.reload).to have_attributes(
            name: "New Name",
            organization_id: organization.id
          )
        end

        it 'returns a hotel' do
          user = create(:user)
          organization = create(:organization)
          hotel = create(:hotel, organization: organization)

          post '/graphql', params: { query: g_query(id: hotel.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:updateHotel]

          expect(data).to include(
            id: "#{ hotel.reload.id }",
            name: "New Name",
            organization: { "id": organization.id.to_s }
          )
        end

        def g_query(id:)
          <<~GQL
            mutation {
              updateHotel(input: {
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
          hotel = create(:hotel, organization: organization)

          post '/graphql', params: { query: g_query(id: hotel.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          expect(json).to have_key(:errors)
        end

        def g_query(id:)
          <<~GQL
            mutation {
              updateHotel( input: {
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
