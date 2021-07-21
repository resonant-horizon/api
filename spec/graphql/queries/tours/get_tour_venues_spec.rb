require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Types::QueryType, type: :request do
  describe 'get venues for a tour' do
    let(:user) { create(:user) }
    let(:org) { create(:organization, user: user) }
    let(:org2) { create(:organization, user: user) }
    let(:tour) { create(:tour, organization: org) }
    let(:day1) { create(:service_day, :for_tour) }
    let(:venue) { create(:venue, organization: org) }
    let(:service_venue) { create(:service_venue) }
    let(:query_type_all) { "tour venues" }
    let(:query_string_all) { <<~GQL
      query tour($id: ID!) {
        tour(id: $id) {
          id
          venues {
            id
            name
            street
            city
            state
            zip
            country
            capacity
          }
        }
      }
    GQL
    }
    describe "return the venues of a tour" do
      before do
        tour
        venue
        day1
        service_venue
        query query_string_all, variables: { id: "#{day1.workable.id}" }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return venues' do
        expect(gql_response.data["tour"]["venues"]).to be_an Array
        expect(gql_response.data["tour"]["venues"]).to eq([{
          "id" => venue.id.to_s,
          "name" => venue.name,
          "street" => venue.street,
          "city" => venue.city,
          "state" => venue.state,
          "zip" => venue.zip,
          "country" => venue.country,
          "capacity" => venue.capacity
        }])
      end
    end
  end
end
