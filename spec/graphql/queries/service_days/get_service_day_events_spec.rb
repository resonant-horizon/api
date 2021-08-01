require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Types::QueryType, type: :request do
  describe 'get events for a service day' do
    let(:user)     { create(:user) }
    let(:org)      { create(:organization, user: user) }
    let(:org2)     { create(:organization, user: user) }
    let(:season)   { create(:season, organization: org) }
    let(:day1)     { create(:service_day, :for_season) }
    let(:event)    { create(:event, service_day: day1) }
    let(:employee) { create(:employee_with_all_data, organization: org) }
    let(:ev_emp)   { create(:event_employee) }
    let(:query_type_all) { "service day events" }
    let(:query_string_all) { <<~GQL
      query serviceDay($id: ID!) {
        serviceDay(id: $id) {
          id
          events {
            id
            name
            startTime
            employees {
              id
              biography {
                lastName
              }
            }
          }
        }
      }
    GQL
    }
    describe "return the service days of a season" do
      before do
        org
        season
        event
        employee
        ev_emp
        event
        query query_string_all, variables: { id: "#{day1.id}" }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return one season of venues' do
        expect(gql_response.data["serviceDay"]["events"]).to be_an Array
        expect(gql_response.data["serviceDay"]["events"]).to eq([{
          "id" => event.id.to_s,
          "name" => event.name,
          "startTime" => Time.parse(event.start_time.to_s).iso8601,
          "employees" => [{
            "id" => employee.id.to_s,
            "biography" => {
              "lastName" => employee.biography.last_name
            }
          }]
        }])
      end
    end
  end
end
