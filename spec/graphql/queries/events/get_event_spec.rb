require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Types::QueryType, type: :request do
  describe 'get an event' do
    let(:user) { create(:user) }
    let(:org) { create(:organization, user: user) }
    let(:org2) { create(:organization, user: user) }
    let(:day1) { create(:service_day, :for_tour) }
    let(:event) { create(:event, service_day: day1) }
    let(:query_type_one) { "event" }
    let(:query_string_one) { <<~GQL
      query event($id: ID!) {
        event(id: $id) {
          id
          name
          description
          startTime
          endTime
          notes
          serviceDay {
            id
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
        query query_string_one, variables: { id: "#{event.id}" }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return an event' do
        expect(gql_response.data["event"]).to be_a Hash
        expect(gql_response.data["event"]).to eq({
          "id" => event.id.to_s,
          "name" => event.name,
          "description" => event.description,
          "startTime" => Time.parse(event.start_time.to_s).iso8601,
          "endTime" => event.end_time,
          "notes" => event.notes,
          "serviceDay" => { "id" => day1.id.to_s }
        })
      end
    end
  end
end
