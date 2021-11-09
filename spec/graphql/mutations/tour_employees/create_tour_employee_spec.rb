require 'rails_helper'

module Mutations
  module TourEmployees
    RSpec.describe CreateTourEmployee, type: :request do
      describe '.resolve' do
        it 'creates a tour employee' do
          user          =  create(:user)
          user2         =  create(:user)
          organization  =  create(:organization, user: user)
          employee      =  create(:employee, organization: organization)
          tour          =  create(:tour, organization: organization)

          expect do
            post '/graphql', params:
              { query: g_query(employee_id: employee.id, tour_id: tour.id)
              }
          end.to change { TourEmployee.count }.by(1)
        end

        it 'returns a tour employee' do
          user          =  create(:user)
          user2         =  create(:user)
          organization  =  create(:organization, user: user)
          employee      =  create(:employee, organization: organization)
          tour         =  create(:tour, organization: organization)

          post '/graphql', params: { query: g_query(employee_id: employee.id, tour_id: tour.id) }

          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:createTourEmployee]

          expect(data).to include(
            id: "#{TourEmployee.first.id}"
          )
        end

        def g_query(employee_id:, tour_id:)
          <<~GQL
            mutation {
              createTourEmployee( input: {
                employeeId: "#{employee_id}"
                tourId: "#{tour_id}"
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
          tour         =  create(:tour, organization: organization)

          post '/graphql', params: { query: g_query(employee_id: employee.id, tour_id: tour.id) }

          json = JSON.parse(response.body, symbolize_names: true)
          expect(json).to have_key(:errors)
        end

        def g_query(tour_id:, employee_id:)
          <<~GQL
            mutation {
              createServiceDay( input: {
                employeeId: "not an id"
                tourId: "not an id"
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
