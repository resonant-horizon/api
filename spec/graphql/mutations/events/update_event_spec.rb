require 'rails_helper'

module Mutations
  module Events
    RSpec.describe Event, type: :request do
      describe 'resolve' do
        it 'updates an event' do
          user = create(:user)
          user2 = create(:user)
          organization = create(:organization, user: user)
          day1 = create(:service_day)
          event = create(:event, service_day: day1)

          post '/graphql', params: { query: g_query(id: event.id) }

          expect(event.reload).to have_attributes(
            name: "New Name",
            service_day_id: day1.id
          )
        end

        it 'returns an event' do
          user = create(:user)
          user2 = create(:user)
          organization = create(:organization, user: user)
          day1 = create(:service_day)
          event = create(:event, service_day: day1)

          post '/graphql', params: { query: g_query(id: event.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:updateEvent]

          expect(data).to include(
            id: "#{ event.reload.id }",
            name: "New Name",
            serviceDay: { "id": day1.id.to_s }
          )
        end

        def g_query(id:)
          <<~GQL
            mutation {
              updateEvent(input: {
                id: #{id}
                name: "New Name"
              }){
                id
                name
                serviceDay {
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
          user2 = create(:user)
          organization = create(:organization, user: user)
          day1 = create(:service_day)
          event = create(:event, service_day: day1)

          post '/graphql', params: { query: g_query(id: event.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          expect(json).to have_key(:errors)
        end

        def g_query(id:)
          <<~GQL
            mutation {
              updateEvent( input: {
                id: 'not an id'
              }) {
                id
                name
                serviceDay {
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
