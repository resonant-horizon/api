require 'rails_helper'

module Mutations
  module Flights
    RSpec.describe CreateFlight, type: :request do
      describe '.resolve' do
        it 'creates a flight' do
          user = create(:user)
          user2 = create(:user)
          organization = create(:organization, user: user)
          day1 = create(:service_day)

          expect do
            post '/graphql', params:
              { query: g_query(service_day_id: day1.id)
              }
          end.to change { Flight.count }.by(1)
        end

        it 'returns a season' do
          user = create(:user)
          user2 = create(:user)
          organization = create(:organization, user: user)
          day1 = create(:service_day)

          post '/graphql', params: { query: g_query(service_day_id: day1.id) }

          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:createFlight]

          expect(data).to include(
            id: "#{Flight.first.id}",
            serviceDay: { "id": day1.id.to_s },
            airlineNetwork: Flight.first.airline_network,
            airline: Flight.first.airline,
            flightNumber: Flight.first.flight_number,
            departureTime: Time.parse(Flight.first.departure_time.to_s),
            departureAirport: Flight.first.departure_airport,
            arrivalTime: Time.parse(Flight.first.departure_time.to_s),
            arrivalAirport: Flight.first.arrival_airport,
            isInternational: Flight.first.is_international
          )
        end

        def g_query(service_day_id:)
          <<~GQL
            mutation {
              createFlight( input: {
                serviceDayId: "#{service_day_id}"
                airlineNetwork: 0
                airline: 0
                flightNumber: "AA1122"
                departureTime: "20000123T012345"
                departureAirport: "LAX"
                arrivalTime: "20000123T012345"
                arrivalAirport: "PIT"
              } ){
                serviceDay {
                  id
                }
                airlineNetwork
                airline
                flightNumber
                departureTime
                departureAirport
                arrivalTime
                arrivalAirport
                isInternational
                id
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
          day1 = create(:service_day)

          post '/graphql', params: { query: g_query(service_day_id: day1.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          expect(json).to have_key(:errors)
        end

        def g_query(service_day_id:)
          <<~GQL
            mutation {
              createFlight( input: {
                organizationId: "not an id"
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
