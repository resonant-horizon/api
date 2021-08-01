require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Types::QueryType, type: :request do
  describe 'get service days' do
    let(:user) { create(:user) }
    let(:org) { create(:organization, user: user) }
    let(:org2) { create(:organization, user: user) }
    let(:day1) { create(:service_day, :for_tour) }
    let(:query_type_all) { "service days" }
    let(:query_string_all) { <<~GQL
      query serviceDay($id: ID!) {
        serviceDay(id: $id) {
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
    GQL
    }
    describe "return a service day" do
      before do
        org
        day1
        query query_string_all, variables: { id: "#{day1.id}" }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return venues' do
        expect(gql_response.data["serviceDay"]).to be_a Hash
        expect(gql_response.data["serviceDay"]).to eq({
          "id" => day1.id.to_s,
          "name" => day1.name,
          "description" => day1.description,
          "date" => day1.date.to_s,
          "hasTravel" => day1.has_travel,
          "hasRehearsal" => day1.has_rehearsal,
          "hasLoadin" => day1.has_loadin,
          "hasLoadout" => day1.has_loadout,
          "hasConcert" => day1.has_concert
        })
      end
    end
  end
end
