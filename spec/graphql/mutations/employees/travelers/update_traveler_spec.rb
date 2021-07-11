require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Mutations::Employees::Travelers::UpdateTraveler, type: :request do
  describe 'Updating a traveler' do

    let(:user) { create(:user) }
    let(:organization) { create(:organization, user: user) }
    let(:employee) { create(:employee, user: user, organization: organization) }
    let(:traveler) { create(:traveler, employee: employee) }
    let(:mutation_type) { "updateTraveler" }
    let(:mutation_string) { <<~GQL
      mutation updateTraveler($input: UpdateTravelerInput!) {
        updateTraveler(input: $input) {
          id
          deltaFf
          americanFf
          unitedFf
          lufthansaFf
          britishAirFf
          seatPreference
        }
      }
    GQL
    }

    context 'happy path' do

      before do
        mutation mutation_string,
          variables: {
            input: {
              id: traveler.id,
              deltaFf: "aldskfj",
              americanFf: "adsfj",
              unitedFf: "asdf",
              lufthansaFf: "ddd",
              britishAirFf: "bar",
              seatPreference: "middle"
            }
          }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return the traveler object' do
        expect(gql_response.data[mutation_type]).to eq({
          "id" => traveler.id.to_s,
          "deltaFf" => "aldskfj",
          "americanFf" => "adsfj",
          "unitedFf" => "asdf",
          "lufthansaFf" => "ddd",
          "britishAirFf" => "bar",
          "seatPreference" => "middle"
          })
      end
    end

    context 'sad path where user input is missing required parameters' do
      before do
        mutation mutation_string,
          variables: {
            input: {
              name: "Invalid input traveler"
            }
          }
      end

      it 'should return errors' do
        expect(gql_response.errors).to be_truthy
      end
    end
  end
end
