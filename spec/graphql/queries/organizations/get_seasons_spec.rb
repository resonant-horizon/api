require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Types::QueryType, type: :request do
  describe 'get seasons for an organization' do
    let(:user) { create(:user) }
    let(:org) { create(:organization, user: user) }
    let(:season) { create(:season, organization: org) }
    let(:query_type_all) { "seasons" }
    let(:query_string_all) { <<~GQL
      query organization($id: ID!) {
        organization(id: $id) {
          id
          seasons {
            id
            name
            isArchived
            startDate
            endDate
            description
          }
        }
      }
    GQL
    }

    context 'Get all seasons for an organization' do

      before do
        org
        season
        query query_string_all, variables: { id: "#{org.id}" }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return an array of season objects' do
        expect(gql_response.data["organization"]["seasons"]).to be_an(Array)
        expect(gql_response.data["organization"]["seasons"]).to eq([{
          "id" => season.id.to_s,
          "name" => season.name,
          "startDate" => season.start_date.to_s,
          "endDate" => season.end_date.to_s,
          "isArchived" => season.is_archived,
          "description" => season.description
        }])
      end
    end

  end
end
