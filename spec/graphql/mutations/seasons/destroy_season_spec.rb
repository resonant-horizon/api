require 'rails_helper'

module Mutations
  module Seasons
    RSpec.describe DestroySeason, type: :request do
      describe 'resolve' do
        it 'removes an season' do
          user = create(:user)
          organization = create(:organization, user_id: user.id)
          season = create(:season, organization: organization)

          expect do
            post '/graphql', params: { query: g_query(id: season.id) }
          end.to change { Season.count }.by(-1)
        end

        it 'returns an organization' do
          user = create(:user)
          organization = create(:organization, user_id: user.id)
          season = create(:season, organization: organization)

          post '/graphql', params: { query: g_query(id: season.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:destroySeason]

          expect(data).to include(
            id: "#{season.id}",
            name: "#{season.name}",
            organization: { "id": season.organization.id.to_s }
          )
        end


        def g_query(id:)
          <<~GQL
            mutation {
              destroySeason( input: {
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
          season = create(:season, organization: organization)

          post '/graphql', params: { query: g_query(id: season.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          expect(json).to have_key(:errors)
        end

        def g_query(id:)
          <<~GQL
            mutation {
              destroySeason( input: {
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
