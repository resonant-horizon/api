require 'rails_helper'

module Mutations
  module SeasonEmployees
    RSpec.describe CreateSeasonEmployee, type: :request do
      describe '.resolve' do
        it 'creates a season employee' do
          user          =  create(:user)
          user2         =  create(:user)
          organization  =  create(:organization, user: user)
          employee      =  create(:employee, organization: organization)
          season          =  create(:season, organization: organization)

          expect do
            post '/graphql', params:
              { query: g_query(employee_id: employee.id, season_id: season.id)
              }
          end.to change { SeasonEmployee.count }.by(1)
        end

        it 'returns a season employee' do
          user          =  create(:user)
          user2         =  create(:user)
          organization  =  create(:organization, user: user)
          employee      =  create(:employee, organization: organization)
          season         =  create(:season, organization: organization)

          post '/graphql', params: { query: g_query(employee_id: employee.id, season_id: season.id) }

          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:createSeasonEmployee]

          expect(data).to include(
            id: "#{SeasonEmployee.first.id}"
          )
        end

        def g_query(employee_id:, season_id:)
          <<~GQL
            mutation {
              createSeasonEmployee( input: {
                employeeId: "#{employee_id}"
                seasonId: "#{season_id}"
              } ){
                id
              }
            }
          GQL
        end
      end

      describe 'sad path' do
        it 'returns errors' do
          user          =  create(:user)
          user2         =  create(:user)
          organization  =  create(:organization, user: user)
          employee      =  create(:employee, organization: organization)
          season         =  create(:season, organization: organization)

          post '/graphql', params: { query: g_query(employee_id: employee.id, season_id: season.id) }

          json = JSON.parse(response.body, symbolize_names: true)
          expect(json).to have_key(:errors)
        end

        def g_query(season_id:, employee_id:)
          <<~GQL
            mutation {
              createServiceDay( input: {
                employeeId: "not an id"
                seasonId: "not an id"
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
