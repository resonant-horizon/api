require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Types::QueryType, type: :request do
  describe 'get service day for a flight' do
    let(:user)  { create(:user) }
    let(:org)   { create(:organization, user: user) }
    let(:org2)  { create(:organization, user: user) }
    let(:tour)  { create(:tour_with_full_employee, organization: org) }
    let(:day1)  { create(:service_day, :for_tour) }
    let(:flight) { create(:flight, service_day: day1) }
    let(:query_type_all) { "service day flights" }
    let(:query_string_all) { <<~GQL
      query flight($id: ID!) {
        flight(id: $id) {
          id
          serviceDay {
            id
            date
          }
        }
      }
    GQL
    }
    describe "return the service day for a flight" do
      before do
        org
        tour
        day1
        flight
        query query_string_all, variables: { id: "#{flight.id}" }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return flights' do
        expect(gql_response.data["flight"]["serviceDay"]).to be_a Hash
        expect(gql_response.data["flight"]["serviceDay"]).to eq({
          "id" => day1.id.to_s,
          "date" => day1.date.to_s
        })
      end
    end
  end
end
