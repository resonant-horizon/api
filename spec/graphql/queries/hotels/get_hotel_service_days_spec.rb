require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Types::QueryType, type: :request do
  describe 'get service days for a hotel' do
    let(:user)            { create(:user) }
    let(:org)             { create(:organization, user: user) }
    let(:org2)            { create(:organization, user: user) }
    let(:season)          { create(:season, organization: org) }
    let(:day1)            { create(:service_day, :for_season) }
    let(:hotel)           { create(:hotel) }
    let(:service_hotel)   { create(:service_hotel) }
    let(:query_type_all) { "hotel service days" }
    let(:query_string_all) { <<~GQL
      query hotel($id: ID!) {
        hotel(id: $id) {
          id
          serviceDays {
            id
            name
            description
            date
            hasTravel
            hasRehearsal
            hasLoadin
            hasLoadout
            hasConcert
          }
        }
      }
    GQL
    }
    describe "return the service days of a hotel" do
      before do
        org
        season
        day1
        hotel
        service_hotel
        query query_string_all, variables: { id: "#{hotel.id}" }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return service days for a hotel' do
        expect(gql_response.data["hotel"]["serviceDays"]).to be_an Array
        expect(gql_response.data["hotel"]["serviceDays"]).to eq([{
          "id" => day1.id.to_s,
          "name" => day1.name,
          "description" => day1.description,
          "date" => day1.date.to_s,
          "hasTravel" => day1.has_travel,
          "hasConcert" => day1.has_concert,
          "hasRehearsal" => day1.has_rehearsal,
          "hasLoadin" => day1.has_loadin,
          "hasLoadout" => day1.has_loadout
        }])
      end
    end
  end
end
