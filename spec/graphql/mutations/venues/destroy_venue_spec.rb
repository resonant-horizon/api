require 'rails_helper'

module Mutations
  module Venues
    RSpec.describe DestroyVenue, type: :request do
      describe 'resolve' do
        it 'removes a venue' do
          user = create(:user)
          organization = create(:organization, user_id: user.id)
          venue = create(:venue, organization: organization)

          expect do
            post '/graphql', params: { query: g_query(id: venue.id) }
          end.to change { Venue.count }.by(-1)
        end

        it 'returns an organization' do
          user = create(:user)
          organization = create(:organization, user_id: user.id)
          venue = create(:venue, organization: organization)

          post '/graphql', params: { query: g_query(id: venue.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:destroyVenue]

          expect(data).to include(
            id: "#{venue.id}",
            name: "#{venue.name}",
            organization: { "id": venue.organization.id.to_s }
          )
        end


        def g_query(id:)
          <<~GQL
            mutation {
              destroyVenue( input: {
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
          venue = create(:venue, organization: organization)

          post '/graphql', params: { query: g_query(id: venue.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          expect(json).to have_key(:errors)
        end

        def g_query(id:)
          <<~GQL
            mutation {
              destroyVenue( input: {
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
