require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Types::QueryType, type: :request do
  describe 'get venue' do
    let(:user) { create(:user) }
    let(:org) { create(:organization, user: user) }
    let(:org2) { create(:organization, user: user) }
    let(:venue) { create(:venue, organization: org) }
    let(:venue2) { create(:venue, organization: org2) }
    let(:query_type_one) { "venue" }
    let(:query_string_one) { <<~GQL
      query venue($id: ID!) {
        venue(id: $id) {
          id
          name
          street
          city
          state
          zip
          country
          capacity
          organization {
            id
          }
          isHeadquarters
        }
      }
    GQL
    }
    describe "return one venue" do
      before do
        venue
        query query_string_one, variables: { id: "#{venue.id}" }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return one venue' do
        expect(gql_response.data["venue"]).to be_a Hash
        expect(gql_response.data["venue"]).to eq({
          "id" => venue.id.to_s,
          "name" => venue.name,
          "isHeadquarters" => venue.is_headquarters,
          "street" => venue.street,
          "city" => venue.city,
          "state" => venue.state,
          "zip" => venue.zip,
          "country" => venue.country,
          "capacity" => venue.capacity,
          "organization" => { "id" => org.id.to_s }
        })
      end
    end
  end
end
