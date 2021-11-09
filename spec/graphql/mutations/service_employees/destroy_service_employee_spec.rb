require 'rails_helper'

module Mutations
  module ServiceEmployees
    RSpec.describe DestroyServiceEmployee, type: :request do
      describe 'resolve' do
        it 'removes a service employee' do
          user = create(:user)
          user2 = create(:user)
          organization = create(:organization, user: user)
          employee = create(:employee, organization: organization)
          tour = create(:tour, organization: organization)
          day1 = create(:service_day, workable: tour)
          service_employee = create(:service_employee, employee: employee, service_day: day1)

          expect do
            post '/graphql', params: { query: g_query(id: service_employee.id) }
          end.to change { ServiceEmployee.count }.by(-1)
        end

        it 'returns a service employee' do
          user = create(:user)
          user2 = create(:user)
          organization = create(:organization, user: user)
          employee = create(:employee, organization: organization)
          tour = create(:tour, organization: organization)
          day1 = create(:service_day, workable: tour)
          service_employee = create(:service_employee, employee: employee, service_day: day1)

          post '/graphql', params: { query: g_query(id: service_employee.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:destroyServiceEmployee]

          expect(data).to include(
            id: "#{service_employee.id}"
          )
        end

        def g_query(id:)
          <<~GQL
            mutation {
              destroyServiceEmployee( input: {
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
          service_employee = create(:service_employee, employee: employee, service_day: day1)

          post '/graphql', params: { query: g_query(id: service_employee.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          expect(json).to have_key(:errors)
        end

        def g_query(id:)
          <<~GQL
            mutation {
              destroyServiceEmployee( input: {
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
