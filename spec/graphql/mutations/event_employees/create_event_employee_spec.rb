require 'rails_helper'

module Mutations
  module EventEmployees
    RSpec.describe CreateEventEmployee, type: :request do
      describe '.resolve' do
        it 'creates an event' do
          user          =  create(:user)
          user2         =  create(:user)
          organization  =  create(:organization, user: user)
          employee      =  create(:employee, organization: organization)
          day1          =  create(:service_day)
          event         =  create(:event, service_day: day1)

          expect do
            post '/graphql', params:
              { query: g_query(employee_id: employee.id, event_id: event.id)
              }
          end.to change { EventEmployee.count }.by(1)
        end

        it 'returns an event' do
          user          =  create(:user)
          user2         =  create(:user)
          organization  =  create(:organization, user: user)
          employee      =  create(:employee, organization: organization)
          day1          =  create(:service_day)
          event         =  create(:event, service_day: day1)

          post '/graphql', params: { query: g_query(employee_id: employee.id, event_id: event.id) }

          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:createEventEmployee]

          expect(data).to include(
            id: "#{EventEmployee.first.id}"
          )
        end

        def g_query(employee_id:, event_id:)
          <<~GQL
            mutation {
              createEventEmployee( input: {
                employeeId: "#{employee_id}"
                eventId: "#{event_id}"
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
          day1          =  create(:service_day)
          event         =  create(:event, service_day: day1)

          post '/graphql', params: { query: g_query(employee_id: employee.id, event_id: event.id) }

          json = JSON.parse(response.body, symbolize_names: true)
          expect(json).to have_key(:errors)
        end

        def g_query(event_id:, employee_id:)
          <<~GQL
            mutation {
              createServiceDay( input: {
                employeeId: "not an id"
                eventId: "not an id"
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
