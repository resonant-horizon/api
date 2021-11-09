require 'rails_helper'

module Mutations
  module Passengers
    RSpec.describe Passenger, type: :request do
      describe 'resolve' do
        it 'updates a passenger' do
          user = create(:user)
          user2 = create(:user)
          organization = create(:organization, user: user)
          employee = create(:employee, organization: organization)
          day1 = create(:service_day)
          flight = create(:flight, service_day: day1)
          passenger = create(:passenger, employee: employee, flight: flight)

          post '/graphql', params: { query: g_query(id: passenger.id) }

          expect(passenger.reload).to have_attributes(
            locator: "New Locator",
            employee_id: employee.id,
            flight_id: flight.id
          )
        end

        it 'returns a passenger' do
          user = create(:user)
          user2 = create(:user)
          organization = create(:organization, user: user)
          employee = create(:employee, organization: organization)
          day1 = create(:service_day)
          flight = create(:flight, service_day: day1)
          passenger = create(:passenger, employee: employee, flight: flight)

          post '/graphql', params: { query: g_query(id: passenger.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:updatePassenger]

          expect(data).to include(
            id: "#{ passenger.reload.id }",
            locator: "New Locator",
            employee: { "id": employee.id.to_s },
            flight: { "id": flight.id.to_s }
          )
        end

        def g_query(id:)
          <<~GQL
            mutation {
              updatePassenger(input: {
                id: #{id}
                locator: "New Locator"
              }){
                id
                locator
                flight {
                  id
                }
                employee {
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
          user2 = create(:user)
          organization = create(:organization, user: user)
          employee = create(:employee, organization: organization)
          day1 = create(:service_day)
          flight = create(:flight, service_day: day1)
          passenger = create(:passenger, employee: employee, flight: flight)

          post '/graphql', params: { query: g_query(id: passenger.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          expect(json).to have_key(:errors)
        end

        def g_query(id:)
          <<~GQL
            mutation {
              updatePassenger( input: {
                id: 'not an id'
              }) {
                id
                locator
                employee {
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
