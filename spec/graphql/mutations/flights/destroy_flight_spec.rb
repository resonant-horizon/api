require 'rails_helper'

module Mutations
  module Flights
    RSpec.describe DestroyFlight, type: :request do
      describe 'resolve' do
        it 'removes a flight' do
          user = create(:user)
          user2 = create(:user)
          organization = create(:organization, user: user)
          day1 = create(:service_day)
          flight = create(:flight, service_day: day1)

          expect do
            post '/graphql', params: { query: g_query(id: flight.id) }
          end.to change { Flight.count }.by(-1)
        end

        it 'returns a flight' do
          user = create(:user)
          user2 = create(:user)
          organization = create(:organization, user: user)
          day1 = create(:service_day)
          flight = create(:flight, service_day: day1)

          post '/graphql', params: { query: g_query(id: flight.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:destroyFlight]

          expect(data).to include(
            id: "#{flight.id}"
          )
        end

        def g_query(id:)
          <<~GQL
            mutation {
              destroyFlight( input: {
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
          day1 = create(:service_day)
          flight = create(:flight, service_day: day1)

          post '/graphql', params: { query: g_query(id: flight.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          expect(json).to have_key(:errors)
        end

        def g_query(id:)
          <<~GQL
            mutation {
              destroyEvent( input: {
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
