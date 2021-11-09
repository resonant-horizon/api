require 'rails_helper'

module Mutations
  module ServiceHotels
    RSpec.describe CreateServiceHotel, type: :request do
      describe '.resolve' do
        it 'creates a service hotel' do
          user          =  create(:user)
          user2         =  create(:user)
          organization  =  create(:organization, user: user)
          tour          =  create(:tour, organization: organization)
          day1          =  create(:service_day, workable: tour)
          hotel         =  create(:hotel, organization: organization)

          expect do
            post '/graphql', params:
              { query: g_query(service_day_id: day1.id, hotel_id: hotel.id)
              }
          end.to change { ServiceHotel.count }.by(1)
        end

        it 'returns a tour hotel' do
          user          =  create(:user)
          user2         =  create(:user)
          organization  =  create(:organization, user: user)
          hotel      =  create(:hotel, organization: organization)
          tour          =  create(:tour, organization: organization)
          day1          =  create(:service_day, workable: tour)
          hotel         =  create(:hotel, organization: organization)

          post '/graphql', params: { query: g_query(service_day_id: day1.id, hotel_id: hotel.id) }

          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:createServiceHotel]

          expect(data).to include(
            id: "#{ServiceHotel.first.id}"
          )
        end

        def g_query(hotel_id:, service_day_id:)
          <<~GQL
            mutation {
              createServiceHotel( input: {
                serviceDayId: "#{service_day_id}"
                hotelId: "#{hotel_id}"
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
          hotel      =  create(:hotel, organization: organization)
          tour         =  create(:tour, organization: organization)
          day1          = create(:service_day, workable: tour)
          hotel         =  create(:hotel, organization: organization)

          post '/graphql', params: { query: g_query(service_day_id: day1.id, hotel_id: hotel.id) }

          json = JSON.parse(response.body, symbolize_names: true)
          expect(json).to have_key(:errors)
        end

        def g_query(hotel_id:, service_day_id:)
          <<~GQL
            mutation {
              createServiceHotel( input: {
                hotelId: "not an id"
                hotelId: "not an id"
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
