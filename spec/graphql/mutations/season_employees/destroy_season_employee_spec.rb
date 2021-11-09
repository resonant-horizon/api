require 'rails_helper'

module Mutations
  module SeasonEmployees
    RSpec.describe DestroySeasonEmployee, type: :request do
      describe 'resolve' do
        it 'removes a season employee' do
          user = create(:user)
          user2 = create(:user)
          organization = create(:organization, user: user)
          employee = create(:employee, organization: organization)
          season = create(:season, organization: organization)
          season_employee = create(:season_employee, employee: employee, season: season)

          expect do
            post '/graphql', params: { query: g_query(id: season_employee.id) }
          end.to change { SeasonEmployee.count }.by(-1)
        end

        it 'returns an season' do
          user = create(:user)
          user2 = create(:user)
          organization = create(:organization, user: user)
          employee = create(:employee, organization: organization)
          season = create(:season, organization: organization)
          season_employee = create(:season_employee, employee: employee, season: season)

          post '/graphql', params: { query: g_query(id: season_employee.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:destroySeasonEmployee]

          expect(data).to include(
            id: "#{season_employee.id}"
          )
        end

        def g_query(id:)
          <<~GQL
            mutation {
              destroySeasonEmployee( input: {
                id: #{id}
              }) {
                id
              }
            }
          GQL
        end
      end

      describe 'sad path' do
        it 'returns with errors' do
          user = create(:user)
          user2 = create(:user)
          organization = create(:organization, user: user)
          employee = create(:employee, organization: organization)
          season = create(:season, organization: organization)
          season_employee = create(:season_employee, employee: employee, season: season)

          post '/graphql', params: { query: g_query(id: season_employee.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          expect(json).to have_key(:errors)
        end

        def g_query(id:)
          <<~GQL
            mutation {
              destroySeasonEmployee( input: {
                id: 'not an id'
              }) {
                id
              }
            }
          GQL
        end
      end
    end
  end
end
