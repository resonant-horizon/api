require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Types::QueryType, type: :request do
  describe 'get hotel' do
    let(:user) { create(:user) }
    let(:org) { create(:organization, user: user) }
    let(:org2) { create(:organization, user: user) }
    let(:hotel) { create(:hotel, organization: org) }
    let(:hotel2) { create(:hotel, organization: org2) }
    let(:query_type_one) { "hotel" }
    let(:query_string_one) { <<~GQL
      query hotel($id: ID!) {
        hotel(id: $id) {
          id
          name
          street
          city
          state
          zip
          country
        }
      }
    GQL
    }
    describe "return one hotel" do
      before do
        hotel
        query query_string_one, variables: { id: "#{hotel.id}" }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return one hotel' do
        expect(gql_response.data["hotel"]).to be_a Hash
        expect(gql_response.data["hotel"]).to eq({
          "id" => hotel.id.to_s,
          "name" => hotel.name,
          "street" => hotel.street,
          "city" => hotel.city,
          "state" => hotel.state,
          "zip" => hotel.zip,
          "country" => hotel.country
        })
      end
    end
  end
end
