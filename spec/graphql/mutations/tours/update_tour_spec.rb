require 'rails_helper'

module Mutations
  module Tours
    RSpec.describe UpdateTour, type: :request do
      describe 'resolve' do
        it 'updates a tour' do
          user = create(:user)
          organization = create(:organization)
          tour = create(:tour, organization: organization)

          post '/graphql', params: { query: g_query(id: tour.id) }

          expect(tour.reload).to have_attributes(
            name: "New Name",
            organization_id: organization.id
          )
        end

        it 'returns a tour' do
          user = create(:user)
          organization = create(:organization)
          tour = create(:tour, organization: organization)

          post '/graphql', params: { query: g_query(id: tour.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:updateTour]

          expect(data).to include(
            id: "#{ tour.reload.id }",
            name: "#{ tour.name }",
            organization: { "id": organization.id.to_s }
          )
        end

        def g_query(id:)
          <<~GQL
            mutation {
              updateTour(input: {
                id: #{id}
                name: "New Name"
              }){
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
              updateTour( input: {
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
