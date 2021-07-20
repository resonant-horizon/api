require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Types::QueryType, type: :request do
  describe 'get tour' do
    let(:user) { create(:user) }
    let(:org) { create(:organization, user: user) }
    let(:org2) { create(:organization, user: user) }
    let(:tour) { create(:tour, organization: org) }
    let(:tour2) { create(:tour, organization: org2) }
    let(:query_type_one) { "tour" }
    let(:query_string_one) { <<~GQL
      query tour($id: ID!) {
        tour(id: $id) {
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
    describe "return one tour" do
      before do
        tour
        query query_string_one, variables: { id: "#{tour.id}" }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return one tour' do
        expect(gql_response.data["tour"]).to be_a Hash
        expect(gql_response.data["tour"]).to eq({
          "id" => tour.id.to_s,
          "name" => tour.name,
          "isArchived" => tour.is_archived,
          "description" => tour.description,
          "endDate" => tour.end_date.to_s,
          "startDate" => tour.start_date.to_s,
          "organization" => { "id" => org.id.to_s }
        })
      end
    end
  end
end
