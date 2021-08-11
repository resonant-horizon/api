require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Types::QueryType, type: :request do
  describe 'get flights for a season' do
    let(:user) { create(:user) }
    let(:org) { create(:organization, user: user) }
    let(:org2) { create(:organization, user: user) }
    let(:emp) { create(:employee_with_all_data) }
    let(:season) { create(:season, organization: org) }
    let(:day1) { create(:service_day, workable: season) }
    let(:flight) { create(:flight, service_day: day1) }
    let(:passenger) { create(:passenger, flight: flight, employee: emp) }
    let(:query_type_all) { "season flights" }
    let(:query_string_all) { <<~GQL
      query season($id: ID!) {
        season(id: $id) {
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
            isInternational
            serviceDay {
              id
              date
            }
            passengers {
              employee {
                biography {
                  firstName
                }
              }
            }
          }
        }
      }
    GQL
    }
    describe "return the flights of a season" do
      before do
        season
        flight
        day1
        passenger
        query query_string_all, variables: { id: "#{day1.workable.id}" }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return flights' do
        expect(gql_response.data["season"]["flights"]).to be_an Array
        expect(gql_response.data["season"]["flights"]).to eq([{
          "id" => flight.id.to_s,
          "airlineNetwork" => flight.airline_network,
          "airline" => flight.airline,
          "flightNumber" => flight.flight_number,
          "departureTime" => Time.parse(flight.departure_time.to_s).iso8601,
          "departureAirport" => flight.departure_airport,
          "arrivalTime" => Time.parse(flight.arrival_time.to_s).iso8601,
          "arrivalAirport" => flight.arrival_airport,
          "isInternational" => flight.is_international,
          "serviceDay" => {
             "id" => flight.service_day.id.to_s,
             "date" => flight.service_day.date.to_s,
          },
          "passengers" => [{
            "employee" => {
              "biography" => {
                "firstName" => passenger.employee.biography.first_name
              }
            }
          }]
        }])
      end
    end
  end
end
