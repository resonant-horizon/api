require 'rails_helper'

module Mutations
  module Hotels
    RSpec.describe DestroyHotel, type: :request do
      describe 'resolve' do
        it 'removes a hotel' do
          user = create(:user)
          organization = create(:organization, user_id: user.id)
          hotel = create(:hotel, organization: organization)

          expect do
            post '/graphql', params: { query: g_query(id: hotel.id) }
          end.to change { Hotel.count }.by(-1)
        end

        it 'returns an organization' do
          user = create(:user)
          organization = create(:organization, user_id: user.id)
          hotel = create(:hotel, organization: organization)

          post '/graphql', params: { query: g_query(id: hotel.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:destroyHotel]

          expect(data).to include(
            id: "#{hotel.id}",
            name: "#{hotel.name}",
            organization: { "id": hotel.organization.id.to_s }
          )
        end


        def g_query(id:)
          <<~GQL
            mutation {
              destroyHotel( input: {
                id: #{id}
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
              destroyHotel( input: {
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
