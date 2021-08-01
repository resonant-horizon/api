require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Types::QueryType, type: :request do
  describe 'get employees for a service day' do
    let(:user) { create(:user) }
    let(:org) { create(:organization, user: user) }
    let(:org2) { create(:organization, user: user) }
    let(:season) { create(:tour_with_full_employee, organization: org) }
    let(:day1) { create(:service_day, :for_tour) }
    let(:service_emp) { create(:service_employee) }
    let(:query_type_one) { "service day employees" }
    let(:query_string_all) { <<~GQL
      query serviceDay($id: ID!) {
        serviceDay(id: $id) {
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
    describe "return the employees of a service day" do
      before do
        org
        season
        day1
        service_emp
        query query_string_all, variables: { id: "#{day1.id}" }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return employees' do
        expect(gql_response.data["serviceDay"]["employees"]).to be_an Array
        expect(gql_response.data["serviceDay"]["employees"]).to eq([{
          "id" => Employee.last.id.to_s,
          "biography" => {
            "firstName" => Employee.last.biography.first_name
          }
        }])
      end
    end
  end
end
