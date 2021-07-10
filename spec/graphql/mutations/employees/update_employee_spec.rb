require 'rails_helper'

module Mutations
  module Employees
    RSpec.describe UpdateEmployee, type: :request do
      describe 'resolve' do
        it 'updates an employee' do
          user = create(:user)
          organization = create(:organization)
          employee = create(:employee, user: user, organization: organization)

          post '/graphql', params: { query: g_query(id: employee.id) }

          expect(employee.reload).to have_attributes(
            employment_status: "full_time"
          )
        end

        it 'returns an employee' do
          user = create(:user)
          organization = create(:organization)
          employee = create(:employee, user: user, organization: organization, employment_status: "contract")

          post '/graphql', params: { query: g_query(id: employee.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:updateEmployee]

          expect(data).to include(
            id: "#{ employee.id }",
            organization: { "id": organization.id.to_s },
            employmentStatus: "#{ employee.reload.employment_status }",
            user: { "id": user.id.to_s }
          )
        end

        def g_query(id:)
          <<~GQL
            mutation {
              updateEmployee(input: {
                id: #{id}
                employmentStatus: "full_time"
              }){
                id
                employmentStatus
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

      # describe 'sad path' do
      #   it 'returns with errors' do
      #     user = create(:user)
      #     organization = create(:organization, user_id: user.id)
      #
      #     post '/graphql', params: { query: g_query(id: organization.id) }
      #     json = JSON.parse(response.body, symbolize_names: true)
      #     expect(json).to have_key(:errors)
      #   end
      #
      #   def g_query(id:)
      #     <<~GQL
      #       mutation {
      #         updateEmployee( input: {
      #           id: 'not an id'
      #         }) {
      #           id
      #           employmentStatus
      #           user {
      #             id
      #           }
      #         }
      #       }
      #     GQL
      #   end
      # end
    end
  end
end
