require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Types::QueryType, type: :request do
  describe 'get season' do
    let(:user) { create(:user) }
    let(:org) { create(:organization, user: user) }
    let(:org2) { create(:organization, user: user) }
    let(:season) { create(:season, organization: org) }
    let(:season2) { create(:season, organization: org2) }
    let(:query_type_one) { "employee" }
    let(:query_string_one) { <<~GQL
      query season($id: ID!) {
        season(id: $id) {
          id
          name
          description
          organization {
            id
          }
          startDate
          endDate
          isArchived
        }
      }
    GQL
    }
    describe "return one season" do
      before do
        season
        query query_string_one, variables: { id: "#{season.id}" }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return one season' do
        expect(gql_response.data["season"]).to be_a Hash
        expect(gql_response.data["season"]).to eq({
          "id" => season.id.to_s,
          "name" => season.name,
          "isArchived" => season.is_archived,
          "description" => season.description,
          "endDate" => season.end_date.to_s,
          "startDate" => season.start_date.to_s,
          "organization" => { "id" => org.id.to_s }
        })
      end
    end
  end
end
