require 'rails_helper'

module Mutations
  module Passengers
    RSpec.describe DestroyPassenger, type: :request do
      describe 'resolve' do
        it 'removes a passenger' do
          user = create(:user)
          user2 = create(:user)
          organization = create(:organization, user: user)
          employee = create(:employee, organization: organization)
          day1 = create(:service_day)
          flight = create(:flight, service_day: day1)
          passenger = create(:passenger, employee: employee, flight: flight)

          expect do
            post '/graphql', params: { query: g_query(id: passenger.id) }
          end.to change { Passenger.count }.by(-1)
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
          data = json[:data][:destroyPassenger]

          expect(data).to include(
            id: "#{passenger.id}"
          )
        end

        def g_query(id:)
          <<~GQL
            mutation {
              destroyPassenger( input: {
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
              destroyPassenger( input: {
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
