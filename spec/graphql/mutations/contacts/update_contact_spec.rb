require 'rails_helper'

module Mutations
  module Contacts
    RSpec.describe UpdateContact, type: :request do
      describe 'resolve' do
        it 'updates a contact' do
          user = create(:user)
          organization = create(:organization)
          contact = create(:contact)

          post '/graphql', params: { query: g_query(id: contact.id) }
          expect(contact.reload).to have_attributes(
            name: "New Name"
          )
        end

        it 'returns a contact' do
          user = create(:user)
          organization = create(:organization)
          contact = create(:contact)

          post '/graphql', params: { query: g_query(id: contact.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:updateContact]

          expect(data).to include(
            id: "#{ contact.reload.id }",
            name: "#{ contact.name }",
            contactableId: contact.contactable_id.to_s
          )
        end

        def g_query(id:)
          <<~GQL
            mutation {
              updateContact(input: {
                id: #{id}
                name: "New Name"
              }){
                id
                name
                contactableId
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
              updateContact( input: {
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
