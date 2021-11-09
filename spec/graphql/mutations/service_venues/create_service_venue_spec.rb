require 'rails_helper'

module Mutations
  module ServiceVenues
    RSpec.describe CreateServiceVenue, type: :request do
      describe '.resolve' do
        it 'creates a service employee' do
          user          =  create(:user)
          user2         =  create(:user)
          organization  =  create(:organization, user: user)
          employee      =  create(:employee, organization: organization)
          tour          =  create(:tour, organization: organization)
          day1          =  create(:service_day, workable: tour)
          venue         =  create(:venue, organization: organization)

          expect do
            post '/graphql', params:
              { query: g_query(service_day_id: day1.id, venue_id: venue.id)
              }
          end.to change { ServiceVenue.count }.by(1)
        end

        it 'returns a tour employee' do
          user          =  create(:user)
          user2         =  create(:user)
          organization  =  create(:organization, user: user)
          employee      =  create(:employee, organization: organization)
          tour          =  create(:tour, organization: organization)
          day1          =  create(:service_day, workable: tour)
          venue         =  create(:venue, organization: organization)

          post '/graphql', params: { query: g_query(service_day_id: day1.id, venue_id: venue.id) }

          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:createServiceVenue]

          expect(data).to include(
            id: "#{ServiceVenue.first.id}"
          )
        end

        def g_query(venue_id:, service_day_id:)
          <<~GQL
            mutation {
              createServiceVenue( input: {
                serviceDayId: "#{service_day_id}"
                venueId: "#{venue_id}"
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
          day1          = create(:service_day, workable: tour)
          venue         =  create(:venue, organization: organization)

          post '/graphql', params: { query: g_query(service_day_id: day1.id, venue_id: venue.id) }

          json = JSON.parse(response.body, symbolize_names: true)
          expect(json).to have_key(:errors)
        end

        def g_query(venue_id:, service_day_id:)
          <<~GQL
            mutation {
              createServiceVenue( input: {
                employeeId: "not an id"
                venueId: "not an id"
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
