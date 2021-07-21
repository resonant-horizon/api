require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Types::QueryType, type: :request do
  describe 'get passengers for a tour' do
    let(:user) { create(:user) }
    let(:org) { create(:organization, user: user) }
    let(:org2) { create(:organization, user: user) }
    let(:emp) { create(:employee_with_all_data)}
    let(:tour) { create(:tour, organization: org) }
    let(:day1) { create(:service_day, :for_tour) }
    let(:flight) { create(:flight, service_day: day1) }
    let(:passenger) { create(:passenger, flight: flight, employee: emp) }
    let(:query_type_all) { "tour passengers" }
    let(:query_string_all) { <<~GQL
      query tour($id: ID!) {
        tour(id: $id) {
          id
          passengers {
            id
            locator
            employee {
              biography {
                firstName
                }
              }
            flight {
              flightNumber
            }
          }
        }
      }
    GQL
    }
    describe "return the passengers of a tour" do
      before do
        tour
        flight
        day1
        passenger
        query query_string_all, variables: { id: "#{day1.workable.id}" }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return passengers' do
        expect(gql_response.data["tour"]["passengers"]).to be_an Array
        expect(gql_response.data["tour"]["passengers"]).to eq([{
          "id" => passenger.id.to_s,
          "employee" => {
            "biography" => {
              "firstName" => passenger.employee.biography.first_name
            }
          },
          "flight" => { "flightNumber" => flight.flight_number },
          "locator" => passenger.locator
        }])
      end
    end
  end
end
