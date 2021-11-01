require 'rails_helper'

module Mutations
  module ServiceDays
    RSpec.describe DestroyServiceDay, type: :request do
      describe 'resolve' do
        it 'removes an service day' do
          user = create(:user)
          organization = create(:organization, user_id: user.id)
          day = create(:service_day, :for_tour)

          expect do
            post '/graphql', params: { query: g_query(id: day.id) }
          end.to change { ServiceDay.count }.by(-1)
        end

        it 'returns an service day' do
          user = create(:user)
          organization = create(:organization, user_id: user.id)
          day = create(:service_day, :for_tour)

          post '/graphql', params: { query: g_query(id: day.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:destroyServiceDay]

          expect(data).to include(
            id: "#{day.id}"
          )
        end

        def g_query(id:)
          <<~GQL
            mutation {
              destroyServiceDay( input: {
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
          organization = create(:organization, user_id: user.id)
          day = create(:service_day, :for_tour)

          post '/graphql', params: { query: g_query(id: day.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          expect(json).to have_key(:errors)
        end

        def g_query(id:)
          <<~GQL
            mutation {
              destroyServiceDay( input: {
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
