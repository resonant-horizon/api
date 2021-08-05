require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Types::QueryType, type: :request do
  describe 'get hotels for an organization' do
    let(:user) { create(:user) }
    let(:org) { create(:organization, user: user) }
    let(:org2) { create(:organization, user: user) }
    let(:season) { create(:season, organization: org) }
    let(:day1) { create(:service_day, :for_season) }
    let(:hotel) { create(:hotel, organization: org) }
    let(:service_hotel) { create(:service_hotel) }
    let(:query_type_all) { "organization hotels" }
    let(:query_string_all) { <<~GQL
      query organization($id: ID!) {
        organization(id: $id) {
          id
          hotels {
            id
            name
            street
            city
            state
            zip
            country
            notes
          }
        }
      }
    GQL
    }
    describe "return the hotels for an organization" do
      before do
        org
        season
        hotel
        day1
        service_hotel
        query query_string_all, variables: { id: "#{org.id}" }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return hotels' do
        expect(gql_response.data["organization"]["hotels"]).to be_an Array
        expect(gql_response.data["organization"]["hotels"]).to eq([{
          "id" => hotel.id.to_s,
          "name" => hotel.name,
          "street" => hotel.street,
          "city" => hotel.city,
          "state" => hotel.state,
          "zip" => hotel.zip,
          "country" => hotel.country,
          "notes" => hotel.notes
        }])
      end
    end
  end
end
