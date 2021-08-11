require 'rails_helper'

module Mutations
  module Seasons
    RSpec.describe UpdateSeason, type: :request do
      describe 'resolve' do
        it 'updates a season' do
          user = create(:user)
          organization = create(:organization)
          season = create(:season, organization: organization)

          post '/graphql', params: { query: g_query(id: season.id) }

          expect(season.reload).to have_attributes(
            name: "New Name",
            organization_id: organization.id
          )
        end

        it 'returns a season' do
          user = create(:user)
          organization = create(:organization)
          season = create(:season, organization: organization)

          post '/graphql', params: { query: g_query(id: season.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:updateSeason]

          expect(data).to include(
            id: "#{ season.reload.id }",
            name: "#{ season.name }",
            organization: { "id": organization.id.to_s }
          )
        end

        def g_query(id:)
          <<~GQL
            mutation {
              updateSeason(input: {
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
          season = create(:season, organization: organization)

          post '/graphql', params: { query: g_query(id: season.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          expect(json).to have_key(:errors)
        end

        def g_query(id:)
          <<~GQL
            mutation {
              updateSeason( input: {
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
