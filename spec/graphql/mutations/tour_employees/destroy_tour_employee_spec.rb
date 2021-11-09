require 'rails_helper'

module Mutations
  module TourEmployees
    RSpec.describe DestroyTourEmployee, type: :request do
      describe 'resolve' do
        it 'removes a tour employee' do
          user = create(:user)
          user2 = create(:user)
          organization = create(:organization, user: user)
          employee = create(:employee, organization: organization)
          tour = create(:tour, organization: organization)
          tour_employee = create(:tour_employee, employee: employee, tour: tour)

          expect do
            post '/graphql', params: { query: g_query(id: tour_employee.id) }
          end.to change { TourEmployee.count }.by(-1)
        end

        it 'returns an event' do
          user = create(:user)
          user2 = create(:user)
          organization = create(:organization, user: user)
          employee = create(:employee, organization: organization)
          tour = create(:tour, organization: organization)
          tour_employee = create(:tour_employee, employee: employee, tour: tour)

          post '/graphql', params: { query: g_query(id: tour_employee.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:destroyTourEmployee]

          expect(data).to include(
            id: "#{tour_employee.id}"
          )
        end

        def g_query(id:)
          <<~GQL
            mutation {
              destroyTourEmployee( input: {
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
          tour_employee = create(:tour_employee, employee: employee, tour: tour)

          post '/graphql', params: { query: g_query(id: tour_employee.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          expect(json).to have_key(:errors)
        end

        def g_query(id:)
          <<~GQL
            mutation {
              destroyTourEmployee( input: {
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
