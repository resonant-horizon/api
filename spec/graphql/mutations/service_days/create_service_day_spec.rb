require 'rails_helper'

module Mutations
  module ServiceDays
    RSpec.describe CreateServiceDay, type: :request do
      describe '.resolve' do
        it 'creates a service day' do
          user = create(:user)
          user2 = create(:user)
          organization = create(:organization, user: user)
          season = create(:season, organization: organization)

          expect do
            post '/graphql', params:
              { query: g_query(workable_id: season.id, workable_type: "#{season.class}")
              }
          end.to change { ServiceDay.count }.by(1)
        end

        it 'returns a service day' do
          user = create(:user)
          user2 = create(:user)
          organization = create(:organization, user: user)
          season = create(:season, organization: organization)

          post '/graphql', params: { query: g_query(workable_id: season.id, workable_type: season.class.to_s) }

          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:createServiceDay]

          expect(data).to include(
            id: "#{ServiceDay.first.id}",
            workableId: season.id.to_s,
            workableType: season.class.to_s,
            name: ServiceDay.first.name,
            description: ServiceDay.first.description,
            date: ServiceDay.first.date.to_s,
            hasRehearsal: ServiceDay.first.has_rehearsal,
            hasConcert: ServiceDay.first.has_concert,
            hasLoadin: ServiceDay.first.has_loadin,
            hasLoadout: ServiceDay.first.has_loadout
            )
        end

        def g_query(workable_id:, workable_type:)
          <<~GQL
            mutation {
              createServiceDay( input: {
                workableId: "#{workable_id}"
                workableType: "#{workable_type}"
                date: "2050-01-01"
              } ){
                id
                name
                date
                description
                workableId
                workableType
                hasRehearsal
                hasConcert
                hasLoadin
                hasLoadout
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
          season = create(:season, organization: organization)

          post '/graphql', params: { query: g_query(workable_id: season.id, workable_type: "#{season.class}") }
          json = JSON.parse(response.body, symbolize_names: true)
          expect(json).to have_key(:errors)
        end

        def g_query(workable_id:, workable_type:)
          <<~GQL
            mutation {
              createServiceDay( input: {
                workableId: "#{workable_id}"
                workableType: "#{workable_type}"
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
