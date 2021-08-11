require 'rails_helper'

module Mutations
  module Seasons
    RSpec.describe CreateSeason, type: :request do
      describe '.resolve' do
        it 'creates a season' do
          user = create(:user)
          user2 = create(:user)
          organization = create(:organization, user: user)

          expect do
            post '/graphql', params:
              { query: g_query(organization_id: organization.id)
              }
          end.to change { Season.count }.by(1)
        end

        it 'returns a season' do
          user = create(:user)
          user2 = create(:user)
          organization = create(:organization, user: user)

          post '/graphql', params: { query: g_query(organization_id: organization.id) }

          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:createSeason]

          expect(data).to include(
            id: "#{Season.first.id}",
            organization: { "id": organization.id.to_s },
            name: Season.first.name,
            description: Season.first.description,
            startDate: Season.first.start_date.to_s,
            endDate: Season.first.end_date.to_s,
            isArchived: Season.first.is_archived
          )
        end

        def g_query(organization_id:)
          <<~GQL
            mutation {
              createSeason( input: {
                organizationId: "#{organization_id}"
                name: "Season Name"
                description: "The Last Season"
                startDate: "2050-01-01"
                endDate: "2050-02-01"
              } ){
                id
                name
                description
                organization {
                  id
                }
                startDate
                endDate
                isArchived
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

        def g_query(user_id:, organization_id:)
          <<~GQL
            mutation {
              createSeason( input: {
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
