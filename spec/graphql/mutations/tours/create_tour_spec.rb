require 'rails_helper'

module Mutations
  module Employees
    RSpec.describe CreateEmployee, type: :request do
      describe '.resolve' do
        it 'creates a tour' do
          user = create(:user)
          user2 = create(:user)
          organization = create(:organization, user: user)

          expect do
            post '/graphql', params:
              { query: g_query(organization_id: organization.id)
              }
          end.to change { Tour.count }.by(1)
        end

        it 'returns a tour' do
          user = create(:user)
          user2 = create(:user)
          organization = create(:organization, user: user)

          post '/graphql', params: { query: g_query(organization_id: organization.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:createTour]

          expect(data).to include(
            id: "#{Tour.first.id}",
            organization: { "id": organization.id.to_s },
            name: Tour.first.name,
            description: Tour.first.description,
            startDate: Tour.first.start_date.to_s,
            endDate: Tour.first.end_date.to_s,
            isArchived: Tour.first.is_archived,
            isInternational: Tour.first.is_international
          )
        end

        def g_query(organization_id:)
          <<~GQL
            mutation {
              createTour( input: {
                organizationId: "#{organization_id}"
                name: "Tour Name"
                description: "The Last Tour"
                startDate: "2050-01-01"
                endDate: "2050-02-01"

              } ){
                id
                name
                description
                organization {
                  id
                }
                startDate
                endDate
                isArchived
                isInternational
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

          post '/graphql', params: { query: g_query(user_id: user2.id, organization_id: organization.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          expect(json).to have_key(:errors)
        end

        def g_query(user_id:, organization_id:)
          <<~GQL
            mutation {
              createEmployee( input: {
                userId: #{user_id}
                organizationId: #{organization_id}
              } ){
                id
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
