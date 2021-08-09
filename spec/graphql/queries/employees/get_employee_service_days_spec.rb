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
    let(:query_type_one) { "employee service days" }
    let(:query_string_all) { <<~GQL
      query employee($id: ID!) {
        employee(id: $id) {
          id
          serviceDays {
            id
            date
          }
        }
      }
    GQL
    }
    describe "return the service days for an employee" do
      before do
        org
        season
        day1
        service_emp
        query query_string_all, variables: { id: "#{Employee.last.id}" }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return employees' do
        expect(gql_response.data["employee"]["serviceDays"]).to be_an Array
        expect(gql_response.data["employee"]["serviceDays"]).to eq([{
          "id" => day1.id.to_s,
          "date" => day1.date.to_s
        }])
      end
    end
  end
end
