require 'rails_helper'

module Mutations
  module Tours
    RSpec.describe DestroyTour, type: :request do
      describe 'resolve' do
        it 'removes an tour' do
          user = create(:user)
          organization = create(:organization, user_id: user.id)
          tour = create(:tour, organization: organization)

          expect do
            post '/graphql', params: { query: g_query(id: tour.id) }
          end.to change { Tour.count }.by(-1)
        end

        it 'returns an organization' do
          user = create(:user)
          organization = create(:organization, user_id: user.id)
          tour = create(:tour, organization: organization)

          post '/graphql', params: { query: g_query(id: tour.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:destroyTour]

          expect(data).to include(
            id: "#{tour.id}",
            name: "#{tour.name}",
            organization: { "id": tour.organization.id.to_s }
          )
        end


        def g_query(id:)
          <<~GQL
            mutation {
              destroyTour( input: {
                id: #{id}
              }) {
                id
                name
                organization {
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
          organization = create(:organization, user_id: user.id)
          tour = create(:tour, organization: organization)

          post '/graphql', params: { query: g_query(id: tour.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          expect(json).to have_key(:errors)
        end

        def g_query(id:)
          <<~GQL
            mutation {
              destroyTour( input: {
                id: 'not an id'
              }) {
                id
                name
                organization {
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
