require 'rails_helper'

module Mutations
  module Contacts
    RSpec.describe DestroyContact, type: :request do
      describe 'resolve' do
        it 'removes a contact' do
          user = create(:user)
          organization = create(:organization, user_id: user.id)
          contact = create(:contact)

          expect do
            post '/graphql', params: { query: g_query(id: contact.id) }
          end.to change { Contact.count }.by(-1)
        end

        it 'returns a contact' do
          user = create(:user)
          organization = create(:organization, user_id: user.id)
          contact = create(:contact)

          post '/graphql', params: { query: g_query(id: contact.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:destroyContact]

          expect(data).to include(
            id: "#{contact.id}"
          )
        end

        def g_query(id:)
          <<~GQL
            mutation {
              destroyContact( input: {
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
          contact = create(:contact)

          post '/graphql', params: { query: g_query(id: contact.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          expect(json).to have_key(:errors)
        end

        def g_query(id:)
          <<~GQL
            mutation {
              destroyContact( input: {
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
