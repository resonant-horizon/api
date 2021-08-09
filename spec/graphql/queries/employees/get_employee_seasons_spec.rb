require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Types::QueryType, type: :request do
  describe 'get employees for a season' do
    let(:user) { create(:user) }
    let(:org) { create(:organization, user: user) }
    let(:org2) { create(:organization, user: user) }
    let(:season) { create(:season_with_full_employee, organization: org) }
    let(:query_type_one) { "employee seasons" }
    let(:query_string_all) { <<~GQL
      query employee($id: ID!) {
        employee(id: $id) {
          id
          seasons {
            id
            name
            startDate
            endDate
          }
        }
      }
    GQL
    }
    describe "return the seasons for an employee" do
      before do
        season
        query query_string_all, variables: { id: "#{Employee.last.id}" }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return seasons' do
        expect(gql_response.data["employee"]["seasons"]).to be_an Array
        expect(gql_response.data["employee"]["seasons"]).to eq([{
          "id"        => season.id.to_s,
          "name"      => season.name,
          "startDate" => season.start_date.to_s,
          "endDate"   => season.end_date.to_s
        }])
      end
    end
  end
end
