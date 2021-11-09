require 'rails_helper'

module Mutations
  module ServiceEmployees
    RSpec.describe CreateServiceEmployee, type: :request do
      describe '.resolve' do
        it 'creates a service employee' do
          user          =  create(:user)
          user2         =  create(:user)
          organization  =  create(:organization, user: user)
          employee      =  create(:employee, organization: organization)
          tour          =  create(:tour, organization: organization)
          day1          = create(:service_day, workable: tour)

          expect do
            post '/graphql', params:
              { query: g_query(employee_id: employee.id, service_day_id: day1.id)
              }
          end.to change { ServiceEmployee.count }.by(1)
        end

        it 'returns a tour employee' do
          user          =  create(:user)
          user2         =  create(:user)
          organization  =  create(:organization, user: user)
          employee      =  create(:employee, organization: organization)
          tour         =  create(:tour, organization: organization)
          day1          = create(:service_day, workable: tour)

          post '/graphql', params: { query: g_query(employee_id: employee.id, service_day_id: day1.id) }

          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:createServiceEmployee]

          expect(data).to include(
            id: "#{ServiceEmployee.first.id}"
          )
        end

        def g_query(employee_id:, service_day_id:)
          <<~GQL
            mutation {
              createServiceEmployee( input: {
                employeeId: "#{employee_id}"
                serviceDayId: "#{service_day_id}"
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

          post '/graphql', params: { query: g_query(employee_id: employee.id, service_day_id: day1.id) }

          json = JSON.parse(response.body, symbolize_names: true)
          expect(json).to have_key(:errors)
        end

        def g_query(service_day_id:, employee_id:)
          <<~GQL
            mutation {
              createServiceDay( input: {
                employeeId: "not an id"
                serviceDayId: "not an id"
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
