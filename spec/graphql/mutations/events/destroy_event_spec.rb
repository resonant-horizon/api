require 'rails_helper'

module Mutations
  module Events
    RSpec.describe DestroyEvent, type: :request do
      describe 'resolve' do
        it 'removes an event' do
          user = create(:user)
          user2 = create(:user)
          organization = create(:organization, user: user)
          day1 = create(:service_day)
          event = create(:event, service_day: day1)

          expect do
            post '/graphql', params: { query: g_query(id: event.id) }
          end.to change { Event.count }.by(-1)
        end

        it 'returns an event' do
          user = create(:user)
          user2 = create(:user)
          organization = create(:organization, user: user)
          day1 = create(:service_day)
          event = create(:event, service_day: day1)

          post '/graphql', params: { query: g_query(id: event.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:destroyEvent]

          expect(data).to include(
            id: "#{event.id}"
          )
        end

        def g_query(id:)
          <<~GQL
            mutation {
              destroyEvent( input: {
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
          day1 = create(:service_day)
          event = create(:event, service_day: day1)

          post '/graphql', params: { query: g_query(id: event.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          expect(json).to have_key(:errors)
        end

        def g_query(id:)
          <<~GQL
            mutation {
              destroyEvent( input: {
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
