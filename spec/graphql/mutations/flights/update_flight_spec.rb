require 'rails_helper'

module Mutations
  module Flights
    RSpec.describe Flight, type: :request do
      describe 'resolve' do
        it 'updates an flight' do
          user = create(:user)
          user2 = create(:user)
          organization = create(:organization, user: user)
          day1 = create(:service_day)
          flight = create(:flight, service_day: day1)

          post '/graphql', params: { query: g_query(id: flight.id) }

          expect(flight.reload).to have_attributes(
            departure_airport: "New Airport Name",
            service_day_id: day1.id
          )
        end

        it 'returns an flight' do
          user = create(:user)
          user2 = create(:user)
          organization = create(:organization, user: user)
          day1 = create(:service_day)
          flight = create(:flight, service_day: day1)

          post '/graphql', params: { query: g_query(id: flight.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:updateFlight]

          expect(data).to include(
            id: "#{ flight.reload.id }",
            departureAirport: "New Airport Name",
            serviceDay: { "id": day1.id.to_s }
          )
        end

        def g_query(id:)
          <<~GQL
            mutation {
              updateFlight(input: {
                id: #{id}
                departureAirport: "New Airport Name"
              }){
                id
                departureAirport
                serviceDay {
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
          day1 = create(:service_day)
          flight = create(:flight, service_day: day1)

          post '/graphql', params: { query: g_query(id: flight.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          expect(json).to have_key(:errors)
        end

        def g_query(id:)
          <<~GQL
            mutation {
              updateFlight( input: {
                id: 'not an id'
              }) {
                id
                name
                serviceDay {
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
