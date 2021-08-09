require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Types::QueryType, type: :request do
  describe 'get employees for an event' do
    let(:user) { create(:user) }
    let(:org) { create(:organization, user: user) }
    let(:org2) { create(:organization, user: user) }
    let(:day1) { create(:service_day, :for_tour) }
    let(:event) { create(:event, service_day: day1) }
    let(:emp) { create(:employee_with_all_data, organization: org) }
    let(:event_employee) { create(:event_employee, event: event, employee: emp)}
    let(:query_type_one) { "event" }
    let(:query_string_one) { <<~GQL
      query event($id: ID!) {
        event(id: $id) {
          id
          name
          employees {
            id
            biography {
              lastName
            }
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
        query query_string_one, variables: { id: "#{event.id}" }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return an event' do
        expect(gql_response.data["event"]["employees"]).to be_an Array
        expect(gql_response.data["event"]["employees"]).to eq([{
          "id" => emp.id.to_s,
          "biography" => {
            "lastName" => emp.biography.last_name
          }
        }])
      end
    end
  end
end
