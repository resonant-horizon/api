require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Types::QueryType, type: :request do
  describe 'get hotels for a service day' do
    let(:user)  { create(:user) }
    let(:org)   { create(:organization, user: user) }
    let(:org2)  { create(:organization, user: user) }
    let(:tour)  { create(:tour_with_full_employee, organization: org) }
    let(:day1)  { create(:service_day, :for_tour) }
    let(:hotel) { create(:hotel, organization: org) }
    let(:service_hotel) { create(:service_hotel) }
    let(:query_type_one) { "service day hotels" }
    let(:query_string_all) { <<~GQL
      query serviceDay($id: ID!) {
        serviceDay(id: $id) {
          id
          hotels {
            id
            name
          }
        }
      }
    GQL
    }
    describe "return the hotels of a service day" do
      before do
        org
        tour
        day1
        hotel
        service_hotel
        query query_string_all, variables: { id: "#{day1.id}" }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return hotels' do
        expect(gql_response.data["serviceDay"]["hotels"]).to be_an Array
        expect(gql_response.data["serviceDay"]["hotels"]).to eq([{
          "id" => hotel.id.to_s,
          "name" => hotel.name
        }])
      end
    end
  end
end
