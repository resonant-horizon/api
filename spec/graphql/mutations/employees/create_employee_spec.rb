require 'rails_helper'

module Mutations
  module Employees
    RSpec.describe CreateEmployee, type: :request do
      describe '.resolve' do
        it 'creates an employee' do
          user = create(:user)
          user2 = create(:user)
          organization = create(:organization, user: user)

          expect do
            post '/graphql', params: { query: g_query(user_id: user2.id, organization_id: organization.id) }
          end.to change { Employee.count }.by(1)
        end

        it 'returns an employee' do
          user = create(:user)
          user2 = create(:user)
          organization = create(:organization, user: user)

          post '/graphql', params: { query: g_query(user_id: user2.id, organization_id: organization.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:createEmployee]

          expect(data).to include(
            id: "#{Employee.first.id}",
            organization: { "id": organization.id.to_s },
            user: { "id": user2.id.to_s },
            instrumentSection: Employee.first.instrument_section,
            employmentStatus: Employee.first.employment_status
          )
        end

        def g_query(user_id:, organization_id:)
          <<~GQL
            mutation {
              createEmployee( input: {
                organizationId: "#{organization_id}"
                userId: "#{user_id}"
                instrumentSection: "nonmusician"
                employmentStatus: "contract"
              } ){
                id
                instrumentSection
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

    #   describe 'sad path' do
    #     it 'returns errors' do
    #       user = create(:user)
    #
    #       post '/graphql', params: { query: g_query(user_id: user.id) }
    #       json = JSON.parse(response.body, symbolize_names: true)
    #       expect(json).to have_key(:errors)
    #     end
    #
    #     def g_query(user_id:)
    #       <<~GQL
    #         mutation {
    #           createOrganization( input: {
    #             userId: #{user_id}
    #           } ){
    #             id
    #             user {
    #               id
    #             }
    #           }
    #         }
    #       GQL
    #     end
    #   end
    end
  end
end
