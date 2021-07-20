require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Types::QueryType, type: :request do
  describe 'get tours for an organization' do
    let(:user) { create(:user) }
    let(:org) { create(:organization, user: user) }
    let(:org2) { create(:organization, user: user) }
    let(:tour) { create(:tour, organization: org) }
    let(:tour2) { create(:tour, organization: org2) }
    let(:query_type_all) { "org tours" }
    let(:query_string_all) { <<~GQL
      query organization($id: ID!) {
        organization(id: $id) {
          id
          tours {
            id
            name
            organization {
              id
            }
            description
            startDate
            endDate
            isInternational
            isArchived
          }
        }
      }
    GQL
    }

    context 'Get all tours for an organization' do

      before do
        org
        tour
        tour2
        query query_string_all, variables: { id: "#{org.id}" }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return an array of tour objects' do
        expect(gql_response.data["organization"]["tours"]).to be_an(Array)
        expect(gql_response.data["organization"]["tours"]).to eq([{
          "id" => tour.id.to_s,
          "name" => tour.name,
          "startDate" => tour.start_date.to_s,
          "endDate" => tour.end_date.to_s,
          "isArchived" => tour.is_archived,
          "description" => tour.description,
          "isInternational" => tour.is_international,
          "organization" => { "id" => org.id.to_s }
        }])
        expect(gql_response.data["organization"]["tours"].last["organization"]["id"]).to_not eq(org2.id)
      end
    end

  end
end
