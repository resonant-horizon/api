require 'rails_helper'

module Mutations
  module Contacts
    RSpec.describe CreateContact, type: :request do
      describe '.resolve' do
        it 'creates a contact' do
          user = create(:user)
          user2 = create(:user)
          organization = create(:organization, user: user)
          hotel = create(:hotel, organization: organization)

          expect do
            post '/graphql', params:
              { query: g_query(contactable_id: hotel.id, contactable_type: "#{hotel.class}", organization_id: organization.id)
              }
          end.to change { Contact.count }.by(1)
        end

        it 'returns a contact' do
          user = create(:user)
          user2 = create(:user)
          organization = create(:organization, user: user)
          hotel = create(:hotel, organization: organization)

          post '/graphql', params: { query: g_query(contactable_id: hotel.id, contactable_type: hotel.class.to_s, organization_id: organization.id) }

          json = JSON.parse(response.body, symbolize_names: true)
          data = json[:data][:createContact]

          expect(data).to include(
            id: "#{Contact.first.id}",
            contactableId: hotel.id.to_s,
            contactableType: hotel.class.to_s,
            name: Contact.first.name,
            description: Contact.first.description,
            phoneNumber: Contact.first.phone_number,
            email: Contact.first.email,
            role: Contact.first.role,
            isPermanentParty: Contact.first.is_permanent_party,
            organization: { "id": Contact.first.organization.id.to_s }
            )
        end

        def g_query(contactable_id:, contactable_type:, organization_id:)
          <<~GQL
            mutation {
              createContact( input: {
                contactableId: "#{contactable_id}"
                contactableType: "#{contactable_type}"
                organizationId: "#{organization_id}"
                name: "Mr. Contact"
                phoneNumber: "3049054973"
                email: "email@hotel.com"
              } ){
                id
                name
                phoneNumber
                description
                email
                contactableId
                contactableType
                isPermanentParty
                role
                organization {
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
          user2 = create(:user)
          organization = create(:organization, user: user)
          hotel = create(:hotel, organization: organization)

          post '/graphql', params: { query: g_query(contactable_id: hotel.id, contactable_type: "#{hotel.class}", organization_id: organization.id) }
          json = JSON.parse(response.body, symbolize_names: true)
          expect(json).to have_key(:errors)
        end

        def g_query(contactable_id:, contactable_type:, organization_id:)
          <<~GQL
            mutation {
              createContact( input: {
                contactableId: "#{contactable_id}"
                contactableType: "#{contactable_type}"
                organizationId: "#{organization_id}"
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
