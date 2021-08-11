require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Types::QueryType, type: :request do
  describe 'get contacts' do
    let(:user)              { create(:user) }
    let(:org)               { create(:organization, user: user) }
    let(:day1)              { create(:service_day, :for_tour) }
    let(:hotel)             { create(:hotel) }
    let(:contact)           { create(:contact, contactable: hotel)}
    let(:query_type_one)    { "contact" }
    let(:query_string_one)  { <<~GQL
      query contact($id: ID!) {
        contact(id: $id) {
          id
          name
          phoneNumber
          email
          description
          role
          isPermanentParty
        }
      }
    GQL
    }
    describe "return the contact" do
      before do
        org
        day1
        hotel
        contact
        query query_string_one, variables: { id: "#{contact.id}" }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return contact' do
        expect(gql_response.data["contact"]).to be_a Hash
        expect(gql_response.data["contact"]).to eq({
            "id" => contact.id.to_s,
            "name" => contact.name,
            "phoneNumber" => contact.phone_number,
            "email" => contact.email,
            "description" => contact.description,
            "role" => contact.role,
            "isPermanentParty" => contact.is_permanent_party
        })
      end
    end
  end
end
