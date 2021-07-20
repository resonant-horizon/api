require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Types::QueryType, type: :request do
  describe 'get service days for a tour' do
    let(:user) { create(:user) }
    let(:org) { create(:organization, user: user) }
    let(:org2) { create(:organization, user: user) }
    let(:tour) { create(:tour, organization: org) }
    let(:day1) { create(:service_day, :for_tour) }
    let(:query_type_all) { "tour service days" }
    let(:query_string_all) { <<~GQL
      query tour($id: ID!) {
        tour(id: $id) {
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
    describe "return the service days of a tour" do
      before do
        tour
        query query_string_all, variables: { id: "#{day1.workable.id}" }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return one tour of venues' do
        expect(gql_response.data["tour"]["serviceDays"]).to be_an Array
        expect(gql_response.data["tour"]["serviceDays"]).to eq([{
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
