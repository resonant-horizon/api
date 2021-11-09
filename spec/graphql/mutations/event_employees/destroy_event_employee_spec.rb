require 'rails_helper'

module Mutations
  module EventEmployees
    RSpec.describe DestroyEventEmployee, type: :request do
      describe 'resolve' do
        it 'removes an event' do
          user = create(:user)
          user2 = create(:user)
          organization = create(:organization, user: user)
          employee = create(:employee, organization: organization)
          day1 = create(:service_day)
          event = create(:event, service_day: day1)
          event_employee = create(:event_employee, employee: employee, event: event)

          expect do
            post '/graphql', params: { query: g_query(id: event_employee.id) }
          end.to change { EventEmployee.count }.by(-1)
        end

        it 'returns an event' do
          user = create(:user)
          user2 = create(:user)
          organization = create(:organization, user: user)
          employee = create(:employee, organization: organization)
          day1 = create(:service_day)
          event = create(:event, service_day: day1)
          event_employee = create(:event_employee, employee: employee, event: event)

          post '/graphql', params: { query: g_query(id: event_employee.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:destroyEventEmployee]

          expect(data).to include(
            id: "#{event_employee.id}"
          )
        end

        def g_query(id:)
          <<~GQL
            mutation {
              destroyEventEmployee( input: {
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
          day1 = create(:service_day)
          event = create(:event, service_day: day1)
          event_employee = create(:event_employee, employee: employee, event: event)

          post '/graphql', params: { query: g_query(id: event_employee.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          expect(json).to have_key(:errors)
        end

        def g_query(id:)
          <<~GQL
            mutation {
              destroyEventEmployee( input: {
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
