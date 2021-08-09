require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Types::QueryType, type: :request do
  describe 'get tours for an employee' do
    let(:user) { create(:user) }
    let(:org) { create(:organization, user: user) }
    let(:org2) { create(:organization, user: user) }
    let(:tour) { create(:tour_with_full_employee, organization: org) }
    let(:query_type_one) { "employee tours" }
    let(:query_string_all) { <<~GQL
      query employee($id: ID!) {
        employee(id: $id) {
          id
          tours {
            id
            name
          }
        }
      }
    GQL
    }
    describe "return the tours of an employee" do
      before do
        tour
        query query_string_all, variables: { id: "#{Employee.last.id}" }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return one tour' do
        expect(gql_response.data["employee"]["tours"]).to be_an Array
        expect(gql_response.data["employee"]["tours"]).to eq([{
          "id" => tour.id.to_s,
          "name" => tour.name
        }])
      end
    end
  end
end
