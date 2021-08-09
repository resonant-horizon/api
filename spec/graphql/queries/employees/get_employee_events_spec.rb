require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Types::QueryType, type: :request do
  describe 'get events for an employees' do
    let(:user) { create(:user) }
    let(:org) { create(:organization, user: user) }
    let(:org2) { create(:organization, user: user) }
    let(:day1) { create(:service_day, :for_tour) }
    let(:event) { create(:event, service_day: day1) }
    let(:emp) { create(:employee_with_all_data, organization: org) }
    let(:event_employee) { create(:event_employee, event: event, employee: emp)}
    let(:query_type_all) { "employee events" }
    let(:query_string_all) { <<~GQL
      query employee($id: ID!) {
        employee(id: $id) {
          id
          biography {
            fullLegalName
          }
          events {
            id
            name
            startTime
          }
        }
      }
    GQL
    }
    describe "return a service day" do
      before do
        org
        day1
        event
        emp
        event_employee
        query query_string_all, variables: { id: "#{emp.id}" }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return an event' do
        expect(gql_response.data["employee"]["events"]).to be_an Array
        expect(gql_response.data["employee"]["events"]).to eq([{
          "id" => event.id.to_s,
          "name" => event.name,
          "startTime" => Time.parse(event.start_time.to_s).iso8601
        }])
      end
    end
  end
end
