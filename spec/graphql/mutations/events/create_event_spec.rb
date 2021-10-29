require 'rails_helper'

module Mutations
  module Events
    RSpec.describe CreateEvent, type: :request do
      describe '.resolve' do
        it 'creates an event' do
          user = create(:user)
          user2 = create(:user)
          organization = create(:organization, user: user)
          day1 = create(:service_day)

          expect do
            post '/graphql', params:
              { query: g_query(service_day_id: day1.id)
              }
          end.to change { Event.count }.by(1)
        end

        it 'returns an event' do
          user = create(:user)
          user2 = create(:user)
          organization = create(:organization, user: user)
          day1 = create(:service_day)

          post '/graphql', params: { query: g_query(service_day_id: day1.id) }

          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:createEvent]

          expect(data).to include(
            id: "#{Event.first.id}",
            name: "My first event",
            description: Event.first.description,
            notes: Event.first.notes,
            serviceDay: { "id": day1.id.to_s },
            location: Event.first.location,
            startTime: Time.parse(Event.first.start_time.to_s)
            )
        end

        def g_query(service_day_id:)
          <<~GQL
            mutation {
              createEvent( input: {
                serviceDayId: "#{service_day_id}"
                startTime: "20000123T012345"
                name: "My first event"
              } ){
                id
                name
                description
                notes
                startTime
                location
                serviceDay {
                  id
                }
              }
            }
          GQL
        end
      end

      # describe 'sad path' do
      #   it 'returns errors' do
      #     user = create(:user)
      #     user2 = create(:user)
      #     organization = create(:organization, user: user)
      #     season = create(:season, organization: organization)
      #
      #     post '/graphql', params: { query: g_query(workable_id: season.id, workable_type: "#{season.class}") }
      #     json = JSON.parse(response.body, symbolize_names: true)
      #     expect(json).to have_key(:errors)
      #   end
      #
      #   def g_query(workable_id:, workable_type:)
      #     <<~GQL
      #       mutation {
      #         createServiceDay( input: {
      #           workableId: "#{workable_id}"
      #           workableType: "#{workable_type}"
      #         } ){
      #           id
      #         }
      #       }
      #     GQL
      #   end
      # end
    end
  end
end
