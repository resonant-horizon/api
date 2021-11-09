require 'rails_helper'

module Mutations
  module EmployeeRoles
    RSpec.describe CreateEmployeeRole, type: :request do
      describe '.resolve' do
        it 'creates an employee role' do
          user = create(:user)
          user2 = create(:user)
          organization = create(:organization, user: user)
          employee = create(:employee, organization: organization)
          role = create(:role)

          expect do
            post '/graphql', params:
              { query: g_query(role_id: role.id, employee_id: employee.id)
              }
          end.to change { EmployeeRole.count }.by(1)
        end

        it 'returns an employee role' do
          user = create(:user)
          user2 = create(:user)
          organization = create(:organization, user: user)
          employee = create(:employee, organization: organization)
          role = create(:role)

          post '/graphql', params:
            { query: g_query(role_id: role.id, employee_id: employee.id)
            }

          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:createEmployeeRole]

          expect(data).to include(
                  id: "#{EmployeeRole.first.id}"
            )
        end

        def g_query(role_id:, employee_id:)
          <<~GQL
            mutation {
              createEmployeeRole( input: {
                roleId: "#{role_id}"
                employeeId: "#{employee_id}"
              } ){
                id
              }
            }
          GQL
        end
      end

      describe 'sad path' do
        it 'returns errors' do
          user = create(:user)
          user2 = create(:user)
          organization = create(:organization, user: user)
          employee = create(:employee, organization: organization)
          role = create(:role)

          post '/graphql', params:
            { query: g_query(role_id: role.id, employee_id: employee.id)
            }

          json = JSON.parse(response.body, symbolize_names: true)
          expect(json).to have_key(:errors)
        end

        def g_query(role_id:, employee_id:)
          <<~GQL
            mutation {
              createEmployeeRole( input: {
                roleId: "not an id"
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
