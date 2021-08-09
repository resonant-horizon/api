require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Types::QueryType, type: :request do
  describe 'get contacts for a hotel' do
    let(:user)              { create(:user) }
    let(:org)               { create(:organization, user: user) }
    let(:day1)              { create(:service_day, :for_tour) }
    let(:hotel)             { create(:hotel) }
    let(:contact)           { create(:contact, contactable: hotel)}
    let(:query_type_all)    { "hotel contacts" }
    let(:query_string_all)  { <<~GQL
      query hotel($id: ID!) {
        hotel(id: $id) {
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
    describe "return the contacts of a hotel" do
      before do
        org
        day1
        hotel
        contact
        query query_string_all, variables: { id: "#{hotel.id}" }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return venues' do
        expect(gql_response.data["hotel"]["contacts"]).to be_an Array
        expect(gql_response.data["hotel"]["contacts"]).to eq([{
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
