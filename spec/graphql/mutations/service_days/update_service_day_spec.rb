require 'rails_helper'

module Mutations
  module ServiceDays
    RSpec.describe UpdateServiceDay, type: :request do
      describe 'resolve' do
        it 'updates a service day' do
          user = create(:user)
          organization = create(:organization)
          day = create(:service_day, :for_tour)

          post '/graphql', params: { query: g_query(id: day.id) }
          expect(day.reload).to have_attributes(
            name: "New Name"
          )
        end

        it 'returns a service day' do
          user = create(:user)
          organization = create(:organization)
          day = create(:service_day, :for_tour)

          post '/graphql', params: { query: g_query(id: day.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:updateServiceDay]

          expect(data).to include(
            id: "#{ day.reload.id }",
            name: "#{ day.name }",
            workableId: day.workable_id.to_s
          )
        end

        def g_query(id:)
          <<~GQL
            mutation {
              updateServiceDay(input: {
                id: #{id}
                name: "New Name"
              }){
                id
                name
                workableId
              }
            }
          GQL
        end
      end

      describe 'sad path' do
        it 'returns with errors' do
          user = create(:user)
          organization = create(:organization, user_id: user.id)
          day = create(:service_day, :for_tour)

          post '/graphql', params: { query: g_query(id: day.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          expect(json).to have_key(:errors)
        end

        def g_query(id:)
          <<~GQL
            mutation {
              updateServiceDay( input: {
                id: 'not an id'
              }) {
                id
                name
              }
            }
          GQL
        end
      end
    end
  end
end
