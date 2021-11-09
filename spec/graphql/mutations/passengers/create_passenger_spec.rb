require 'rails_helper'

module Mutations
  module Passengers
    RSpec.describe CreatePassenger, type: :request do
      describe '.resolve' do
        it 'creates a passenger' do
          user = create(:user)
          user2 = create(:user)
          organization = create(:organization, user: user)
          employee = create(:employee, organization: organization)
          day1 = create(:service_day)
          flight = create(:flight, service_day: day1)

          expect do
            post '/graphql', params:
              { query: g_query(flight_id: flight.id, employee_id: employee.id)
              }
          end.to change { Passenger.count }.by(1)
        end

        it 'returns a passenger' do
          user = create(:user)
          user2 = create(:user)
          organization = create(:organization, user: user)
          employee = create(:employee, organization: organization)
          day1 = create(:service_day)
          flight = create(:flight, service_day: day1)

          post '/graphql', params:
            { query: g_query(flight_id: flight.id, employee_id: employee.id)
            }

          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:createPassenger]

          expect(data).to include(
                  id: "#{Passenger.first.id}",
             locator: "UIX203",
            employee: { id: Passenger.first.employee.id.to_s },
              flight: { id: Passenger.first.flight.id.to_s }
            )
        end

        def g_query(flight_id:, employee_id:)
          <<~GQL
            mutation {
              createPassenger( input: {
                flightId: "#{flight_id}"
                employeeId: "#{employee_id}"
                locator: "UIX203"
              } ){
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
        it 'returns errors' do
          user = create(:user)
          user2 = create(:user)
          organization = create(:organization, user: user)
          employee = create(:employee, organization: organization)
          day1 = create(:service_day)
          flight = create(:flight, service_day: day1)

          post '/graphql', params:
            { query: g_query(flight_id: flight.id, employee_id: employee.id)
            }

          json = JSON.parse(response.body, symbolize_names: true)
          expect(json).to have_key(:errors)
        end

        def g_query(flight_id:, employee_id:)
          <<~GQL
            mutation {
              createPassenger( input: {
                serviceDayId: "not an id"
                locator: "not a locator"
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
