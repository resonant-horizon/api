require 'rails_helper'

module Mutations
  module EmployeeRoles
    RSpec.describe DestroyEmployeeRole, type: :request do
      describe 'resolve' do
        it 'removes an employee role' do
          user = create(:user)
          user2 = create(:user)
          organization = create(:organization, user: user)
          employee = create(:employee, organization: organization)
          role = create(:role)
          employee_role = create(:employee_role, employee: employee, role: role)

          expect do
            post '/graphql', params: { query: g_query(id: employee_role.id) }
          end.to change { EmployeeRole.count }.by(-1)
        end

        it 'returns an employee role' do
          user = create(:user)
          user2 = create(:user)
          organization = create(:organization, user: user)
          employee = create(:employee, organization: organization)
          role = create(:role)
          employee_role = create(:employee_role, employee: employee, role: role)

          post '/graphql', params: { query: g_query(id: employee_role.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:destroyEmployeeRole]

          expect(data).to include(
            id: "#{employee_role.id}"
          )
        end

        def g_query(id:)
          <<~GQL
            mutation {
              destroyEmployeeRole( input: {
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
          role = create(:role)
          employee_role = create(:employee_role, employee: employee, role: role)

          post '/graphql', params: { query: g_query(id: employee_role.id) }

          json = JSON.parse(response.body, symbolize_names: true)
          expect(json).to have_key(:errors)
        end

        def g_query(id:)
          <<~GQL
            mutation {
              destroyEmployeeRole( input: {
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
