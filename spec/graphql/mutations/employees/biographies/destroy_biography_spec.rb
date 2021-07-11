require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Mutations::Employees::Biographies::DestroyBiography, type: :request do
  describe 'Destroying a Biography' do

    let(:user) { create(:user) }
    let(:organization) { create(:organization, user: user) }
    let(:employee) { create(:employee, user: user, organization: organization) }
    let(:biography) { create(:biography, employee: employee) }
    let(:mutation_type) { "destroyBiography" }
    let(:mutation_string) { <<~GQL
      mutation destroyBiography($input: DestroyBiographyInput!) {
        destroyBiography(input: $input) {
          id
        }
      }
    GQL
    }

    context 'happy path' do

      before do
        biography
        mutation mutation_string,
          variables: {
            input: {
              id: biography.id
            }
          }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should delete the object' do
        expect(Biography.all).to be_empty
      end

      it 'should return the biography object id that was destroyed' do
        expect(gql_response.data[mutation_type]).to eq({
          "id" => biography.id.to_s
          })
      end
    end

    context 'sad path where user input is missing required parameters' do
      before do
        mutation mutation_string,
          variables: {
            input: {
              name: "Not destroyed",
            }
          }
      end

      it 'should return errors' do
        expect(gql_response.errors).to be_truthy
      end
    end
  end
end
