require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Types::QueryType, type: :request do
  describe 'get flight' do
    let(:user) { create(:user) }
    let(:org) { create(:organization, user: user) }
    let(:org2) { create(:organization, user: user) }
    let(:season) { create(:season, organization: org) }
    let(:day1) { create(:service_day, workable: season) }
    let(:flight) { create(:flight, service_day: day1) }
    let(:query_type_one) { "flight" }
    let(:query_string_one) { <<~GQL
      query flight($id: ID!) {
        flight(id: $id) {
          id
          airlineNetwork
          airline
          flightNumber
          departureTime
          serviceDay {
            id
          }
        }
      }
    GQL
    }
    describe "return one flight" do
      before do
        org
        season
        day1
        flight
        query query_string_one, variables: { id: "#{flight.id}" }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return one flight' do
        expect(gql_response.data["flight"]).to be_a Hash
        expect(gql_response.data["flight"]).to eq({
          "id" => flight.id.to_s,
          "airlineNetwork" => flight.airline_network,
          "airline" => flight.airline,
          "flightNumber" => flight.flight_number,
          "departureTime" => Time.parse(flight.departure_time.to_s).iso8601,
          "serviceDay" => { "id" => day1.id.to_s }
        })
      end
    end
  end
end
