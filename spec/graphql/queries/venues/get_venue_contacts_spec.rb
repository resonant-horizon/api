require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Types::QueryType, type: :request do
  describe 'get contacts for a venue' do
    let(:user)              { create(:user) }
    let(:org)               { create(:organization, user: user) }
    let(:day1)              { create(:service_day, :for_tour) }
    let(:venue)             { create(:venue) }
    let(:contact)           { create(:contact, contactable: venue)}
    let(:query_type_all)    { "venue contacts" }
    let(:query_string_all)  { <<~GQL
      query venue($id: ID!) {
        venue(id: $id) {
          id
          name
          contacts {
            id
            name
            phoneNumber
            email
            description
            role
            isPermanentParty
          }
        }
      }
    GQL
    }
    describe "return the venues of a venue" do
      before do
        org
        day1
        venue
        contact
        query query_string_all, variables: { id: "#{venue.id}" }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return venues' do
        expect(gql_response.data["venue"]["contacts"]).to be_an Array
        expect(gql_response.data["venue"]["contacts"]).to eq([{
            "id" => contact.id.to_s,
            "name" => contact.name,
            "phoneNumber" => contact.phone_number,
            "email" => contact.email,
            "description" => contact.description,
            "role" => contact.role,
            "isPermanentParty" => contact.is_permanent_party
        }])
      end
    end
  end
end
