require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Types::QueryType, type: :request do
  describe 'get employees for a season' do
    let(:user) { create(:user) }
    let(:org) { create(:organization, user: user) }
    let(:org2) { create(:organization, user: user) }
    let(:season) { create(:season_with_full_employee, organization: org) }
    let(:query_type_one) { "season employees" }
    let(:query_string_all) { <<~GQL
      query season($id: ID!) {
        season(id: $id) {
          id
          employees {
            id
            biography {
              firstName
            }
          }
        }
      }
    GQL
    }
    describe "return the employees of a season" do
      before do
        season
        query query_string_all, variables: { id: "#{season.id}" }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return one season' do
        expect(gql_response.data["season"]["employees"]).to be_an Array
        expect(gql_response.data["season"]["employees"]).to eq([{
          "id" => Employee.last.id.to_s,
          "biography" => {
            "firstName" => Employee.last.biography.first_name
          }
        }])
      end
    end
  end
end
