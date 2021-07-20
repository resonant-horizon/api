require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Types::QueryType, type: :request do
  describe 'get contacts for a tour' do
    let(:user)              { create(:user) }
    let(:org)               { create(:organization, user: user) }
    let(:day1)              { create(:service_day, :for_tour) }
    let(:contact)           { create(:contact) }
    let(:service_venue)     { create(:service_venue)}
    let(:query_type_all)    { "tour venues" }
    let(:query_string_all)  { <<~GQL
      query tour($id: ID!) {
        tour(id: $id) {
          id
          contacts {
            id
            venue {
              id
              name
            }
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
    describe "return the venues of a tour" do
      before do
        org
        day1
        contact
        service_venue
        query query_string_all, variables: { id: "#{day1.workable.id}" }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return venues' do
        expect(gql_response.data["tour"]["contacts"]).to be_an Array
        expect(gql_response.data["tour"]["contacts"]).to eq([{
            "id" => contact.id.to_s,
            "venue" => {
              "id" => Venue.last.id.to_s,
              "name" => Venue.last.name
            },
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
