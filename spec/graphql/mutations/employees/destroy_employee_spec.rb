require 'rails_helper'

module Mutations
  module Employees
    RSpec.describe DestroyEmployee, type: :request do
      describe 'resolve' do
        it 'removes an employee' do
          user = create(:user)
          organization = create(:organization, user_id: user.id)
          employee = create(:employee, user: user, organization: organization)

          expect do
            post '/graphql', params: { query: g_query(id: employee.id) }
          end.to change { Employee.count }.by(-1)
        end

        it 'returns an organization' do
          user = create(:user)
          organization = create(:organization, user_id: user.id)
          employee = create(:employee, user: user, organization: organization)

          post '/graphql', params: { query: g_query(id: employee.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:destroyEmployee]

          expect(data).to include(
            id: "#{employee.id}",
            organization: { "id": employee.organization.id.to_s },
            user: { "id": employee.user.id.to_s }
          )
        end


        def g_query(id:)
          <<~GQL
            mutation {
              destroyEmployee( input: {
                id: #{id}
              }) {
                id
                organization {
                  id
                }
                user {
                  id
                }
              }
            }
          GQL
        end
      end

      describe 'sad path' do
        it 'returns with errors' do
          user = create(:user)
          organization = create(:organization, user_id: user.id)
          employee = create(:employee, user: user, organization: organization)

          post '/graphql', params: { query: g_query(id: employee.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          expect(json).to have_key(:errors)
        end

        def g_query(id:)
          <<~GQL
            mutation {
              destroyEmployee( input: {
                id: 'not an id'
              }) {
                id
                firstName
                lastName
                email
                phoneNumber
                note
                user {
                  id
                }
              }
            }
          GQL
        end
      end
    end
  end
end
