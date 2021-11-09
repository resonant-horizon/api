require 'rails_helper'

module Mutations
  module ServiceVenues
    RSpec.describe DestroyServiceVenue, type: :request do
      describe 'resolve' do
        it 'removes a service venue' do
          user = create(:user)
          user2 = create(:user)
          organization = create(:organization, user: user)
          tour = create(:tour, organization: organization)
          day1 = create(:service_day, workable: tour)
          venue = create(:venue, organization: organization)
          service_venue = create(:service_venue, venue: venue, service_day: day1)

          expect do
            post '/graphql', params: { query: g_query(id: service_venue.id) }
          end.to change { ServiceVenue.count }.by(-1)
        end

        it 'returns a service venue' do
          user = create(:user)
          user2 = create(:user)
          organization = create(:organization, user: user)
          employee = create(:employee, organization: organization)
          tour = create(:tour, organization: organization)
          day1 = create(:service_day, workable: tour)
          venue = create(:venue, organization: organization)
          service_venue = create(:service_venue, venue: venue, service_day: day1)

          post '/graphql', params: { query: g_query(id: service_venue.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:destroyServiceVenue]

          expect(data).to include(
            id: "#{service_venue.id}"
          )
        end

        def g_query(id:)
          <<~GQL
            mutation {
              destroyServiceVenue( input: {
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
          tour = create(:tour, organization: organization)
          day1 = create(:service_day, workable: tour)
          venue = create(:venue, organization: organization)
          service_venue = create(:service_venue, venue: venue, service_day: day1)

          post '/graphql', params: { query: g_query(id: service_venue.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          expect(json).to have_key(:errors)
        end

        def g_query(id:)
          <<~GQL
            mutation {
              destroyServiceVenue( input: {
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
