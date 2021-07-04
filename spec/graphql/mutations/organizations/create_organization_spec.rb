require 'rails_helper'

module Mutations
  module Organizations
    RSpec.describe CreateOrganization, type: :request do
      describe '.resolve' do
        it 'creates an organization' do
          user = create(:user)

          expect do
            post '/graphql', params: { query: g_query(user_id: user.id) }
          end.to change { Organization.count }.by(1)
        end

        it 'returns an organization' do
          user = create(:user)

          post '/graphql', params: { query: g_query(user_id: user.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:createOrganization]

          expect(data).to include(
            id: "#{Organization.first.id}",
            name: "LAMC",
            user: { "id": user.id.to_s }
          )
        end

        def g_query(user_id:)
          <<~GQL
            mutation {
              createOrganization( input: {
                name: "LAMC"
                userId: "#{user_id}"
                contactName: "Sahundra Beans"
                contactEmail: "sb@123.com"
                phoneNumber: "3214568899"
                streetAddress: "1 Best Choir Rd."
                city: "Los Angeles"
                state: "CA"
                zip: "78200"
              } ){
                id
                name
                contactName
                contactEmail
                phoneNumber
                streetAddress
                city
                state
                zip
                user {
                  id
                }
              }
            }
          GQL
        end
      end

      describe 'sad path' do
        it 'returns errors' do
          user = create(:user)

          post '/graphql', params: { query: g_query(user_id: user.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          expect(json).to have_key(:errors)
        end

        def g_query(user_id:)
          <<~GQL
            mutation {
              createOrganization( input: {
                userId: #{user_id}
              } ){
                id
                user {
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
