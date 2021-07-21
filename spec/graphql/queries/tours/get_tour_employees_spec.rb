require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Types::QueryType, type: :request do
  describe 'get employees for a tour' do
    let(:user) { create(:user) }
    let(:org) { create(:organization, user: user) }
    let(:org2) { create(:organization, user: user) }
    let(:tour) { create(:tour_with_full_employee, organization: org) }
    let(:query_type_one) { "tour employees" }
    let(:query_string_all) { <<~GQL
      query tour($id: ID!) {
        tour(id: $id) {
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
    describe "return the employees of a tour" do
      before do
        tour
        query query_string_all, variables: { id: "#{tour.id}" }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return one tour' do
        expect(gql_response.data["tour"]["employees"]).to be_an Array
        expect(gql_response.data["tour"]["employees"]).to eq([{
          "id" => Employee.last.id.to_s,
          "biography" => {
            "firstName" => Employee.last.biography.first_name
          }
        }])
      end
    end
  end
end
