require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Mutations::Employees::Travelers::CreateTraveler, type: :request do
  describe 'Creating a biography' do
    let(:user)  { create(:user)  }
    let(:user2) { create(:user) }
    let(:organization) { create(:organization, user: user) }
    let(:employee) {
      create(:employee, organization: organization, user: user2)
    }
    let(:mutation_type) { "createTraveler" }
    let(:mutation_string) { <<~GQL
      mutation createTraveler($input: CreateTravelerInput!) {
        createTraveler(input: $input) {
          deltaFf
          americanFf
          unitedFf
          lufthansaFf
          britishAirFf
          seatPreference
          employee {
            id
          }
        }
      }
    GQL
    }

    context 'happy path' do
      before do
        mutation mutation_string,
          variables: {
            input: {
              employeeId: employee.id,
              deltaFf: "new",
              americanFf: "new aa",
              unitedFf: "new united",
              lufthansaFf: "new lufta",
              britishAirFf: "new ba",
              seatPreference: "middle"
            }
          }
        end
        it 'should return no errors' do
          expect(gql_response.errors).to be_nil
        end

        it 'should return the biography object' do
          expect(gql_response.data[mutation_type]).to eq({
            "deltaFf" => "new",
            "americanFf" => "new aa",
            "unitedFf" => "new united",
            "lufthansaFf" => "new lufta",
            "britishAirFf" => "new ba",
            "seatPreference" => "middle",
            "employee" =>
                {
                  "id" => Traveler.last.employee.id.to_s
                }
            })
        end
      end

    context 'sad path where user input is missing required parameters' do
      before do
        mutation mutation_string,
          variables: {
            input: {
              id: "Invalid input for traveler",
            }
          }
      end

      it 'should return errors' do
        expect(gql_response.errors).to be_truthy
      end
    end
  end
end
