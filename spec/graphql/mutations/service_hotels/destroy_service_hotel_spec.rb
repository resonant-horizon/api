require 'rails_helper'

module Mutations
  module ServiceHotels
    RSpec.describe DestroyServiceHotel, type: :request do
      describe 'resolve' do
        it 'removes a service hotel' do
          user = create(:user)
          user2 = create(:user)
          organization = create(:organization, user: user)
          tour = create(:tour, organization: organization)
          day1 = create(:service_day, workable: tour)
          hotel = create(:hotel, organization: organization)
          service_hotel = create(:service_hotel, hotel: hotel, service_day: day1)

          expect do
            post '/graphql', params: { query: g_query(id: service_hotel.id) }
          end.to change { ServiceHotel.count }.by(-1)
        end

        it 'returns a service hotel' do
          user = create(:user)
          user2 = create(:user)
          organization = create(:organization, user: user)
          employee = create(:employee, organization: organization)
          tour = create(:tour, organization: organization)
          day1 = create(:service_day, workable: tour)
          hotel = create(:hotel, organization: organization)
          service_hotel = create(:service_hotel, hotel: hotel, service_day: day1)

          post '/graphql', params: { query: g_query(id: service_hotel.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:destroyServiceHotel]

          expect(data).to include(
            id: "#{service_hotel.id}"
          )
        end

        def g_query(id:)
          <<~GQL
            mutation {
              destroyServiceHotel( input: {
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
          hotel = create(:hotel, organization: organization)
          service_hotel = create(:service_hotel, hotel: hotel, service_day: day1)

          post '/graphql', params: { query: g_query(id: service_hotel.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          expect(json).to have_key(:errors)
        end

        def g_query(id:)
          <<~GQL
            mutation {
              destroyServiceHotel( input: {
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
