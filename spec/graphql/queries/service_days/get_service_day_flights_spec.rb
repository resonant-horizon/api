require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Types::QueryType, type: :request do
  describe 'get employees for a service day' do
    let(:user)  { create(:user) }
    let(:org)   { create(:organization, user: user) }
    let(:org2)  { create(:organization, user: user) }
    let(:tour)  { create(:tour_with_full_employee, organization: org) }
    let(:day1)  { create(:service_day, :for_tour) }
    let(:flight) { create(:flight, service_day: day1) }
    let(:query_type_all) { "service day flights" }
    let(:query_string_all) { <<~GQL
      query serviceDay($id: ID!) {
        serviceDay(id: $id) {
          id
          flights {
            id
            airlineNetwork
            airline
            flightNumber
            departureTime
            departureAirport
            arrivalTime
            arrivalAirport
          }
        }
      }
    GQL
    }
    describe "return the flights of a service day" do
      before do
        org
        tour
        day1
        flight
        query query_string_all, variables: { id: "#{day1.id}" }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return venues' do
        expect(gql_response.data["serviceDay"]["flights"]).to be_an Array
        expect(gql_response.data["serviceDay"]["flights"]).to eq([{
          "id" => flight.id.to_s,
          "airlineNetwork" => flight.airline_network,
          "airline" => flight.airline,
          "flightNumber" => flight.flight_number,
          "departureTime" => flight.departure_time.to_s,
          "departureAirport" => flight.departure_airport,
          "arrivalTime" => flight.arrival_time.to_s,
          "arrivalAirport" => flight.arrival_airport
        }])
      end
    end
  end
end
