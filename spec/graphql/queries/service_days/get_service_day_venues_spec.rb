require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Types::QueryType, type: :request do
  describe 'get venues for a service day' do
    let(:user)  { create(:user) }
    let(:org)   { create(:organization, user: user) }
    let(:org2)  { create(:organization, user: user) }
    let(:tour)  { create(:tour_with_full_employee, organization: org) }
    let(:day1)  { create(:service_day, :for_tour) }
    let(:venue) { create(:venue, organization: org) }
    let(:service_venue) { create(:service_venue) }
    let(:query_type_one) { "service day venues" }
    let(:query_string_all) { <<~GQL
      query serviceDay($id: ID!) {
        serviceDay(id: $id) {
          id
          venues {
            id
            name
          }
        }
      }
    GQL
    }
    describe "return the venues of a service day" do
      before do
        org
        tour
        day1
        venue
        service_venue
        query query_string_all, variables: { id: "#{day1.id}" }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return venues' do
        expect(gql_response.data["serviceDay"]["venues"]).to be_an Array
        expect(gql_response.data["serviceDay"]["venues"]).to eq([{
          "id" => venue.id.to_s,
          "name" => venue.name
        }])
      end
    end
  end
end
