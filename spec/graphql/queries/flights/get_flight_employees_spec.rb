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
    let(:passenger) { create(:passenger, flight: flight, employee: Employee.last) }
    let(:query_type_all) { "passengers" }
    let(:query_string_all) { <<~GQL
      query flight($id: ID!) {
        flight(id: $id) {
          id
          employees {
            id
            biography {
              fullLegalName
            }
          }
        }
      }
    GQL
    }
    describe "return the employees for a flight" do
      before do
        org
        tour
        day1
        flight
        passenger
        query query_string_all, variables: { id: "#{flight.id}" }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return flights' do
        expect(gql_response.data["flight"]["employees"]).to be_an Array
        expect(gql_response.data["flight"]["employees"]).to eq([{
          "id" => Employee.last.id.to_s,
          "biography" => { "fullLegalName" => Employee.last.biography.full_legal_name }
        }])
      end
    end
  end
end
