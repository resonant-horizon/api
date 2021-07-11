require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Mutations::Employees::Travelers::DestroyTraveler, type: :request do
  describe 'Destroying a Traveler' do

    let(:user) { create(:user) }
    let(:organization) { create(:organization, user: user) }
    let(:employee) { create(:employee, user: user, organization: organization) }
    let(:traveler) { create(:traveler, employee: employee) }
    let(:mutation_type) { "destroyTraveler" }
    let(:mutation_string) { <<~GQL
      mutation destroyTraveler($input: DestroyTravelerInput!) {
        destroyTraveler(input: $input) {
          id
        }
      }
    GQL
    }

    context 'happy path' do

      before do
        mutation mutation_string,
          variables: {
            input: {
              id: traveler.id
            }
          }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should delete the object' do
        expect(Traveler.all).to be_empty
      end

      it 'should return the traveler object id that was destroyed' do
        expect(gql_response.data[mutation_type]).to eq({
          "id" => traveler.id.to_s,
          })
      end
    end

    context 'sad path where user input is missing required parameters' do
      before do
        mutation mutation_string,
          variables: {
            input: {
              name: "Not destroyed"
            }
          }
      end

      it 'should return errors' do
        expect(gql_response.errors).to be_truthy
      end
    end
  end
end
