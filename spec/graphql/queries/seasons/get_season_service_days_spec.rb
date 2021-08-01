require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Types::QueryType, type: :request do
  describe 'get service days for a season' do
    let(:user) { create(:user) }
    let(:org) { create(:organization, user: user) }
    let(:org2) { create(:organization, user: user) }
    let(:season) { create(:season, organization: org) }
    let(:day1) { create(:service_day, :for_season) }
    let(:query_type_all) { "season service days" }
    let(:query_string_all) { <<~GQL
      query season($id: ID!) {
        season(id: $id) {
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
    describe "return the service days of a season" do
      before do
        season
        query query_string_all, variables: { id: "#{day1.workable.id}" }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return one season of venues' do
        expect(gql_response.data["season"]["serviceDays"]).to be_an Array
        expect(gql_response.data["season"]["serviceDays"]).to eq([{
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
