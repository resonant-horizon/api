require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Mutations::Employees::Biographies::UpdateBiography, type: :request do
  describe 'Updating a biography' do

    let(:user) { create(:user) }
    let(:organization) { create(:organization, user: user) }
    let(:employee) { create(:employee, user: user, organization: organization) }
    let(:biography) { create(:biography, employee: employee) }
    let(:mutation_type) { "updateBiography" }
    let(:mutation_string) { <<~GQL
      mutation updateBiography($input: UpdateBiographyInput!) {
        updateBiography(input: $input) {
          id
          firstName
          lastName
          fullLegalName
          phoneNumber
          email
          street
          city
          state
          zip
          ssn
        }
      }
    GQL
    }

    context 'happy path' do

      before do
        mutation mutation_string,
          variables: {
            input: {
              id: biography.id.to_s,
              firstName: "Updated First",
              lastName: "Updated Last",
              fullLegalName: "Updated Full Legal",
              phoneNumber: "1233455566",
              email: "updated@email.com",
              street: "Updated Street",
              city: "Updated City",
              state: "A New State",
              zip: "109876",
              ssn: "876998789"
            }
          }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return the SubEvent object' do
        expect(gql_response.data[mutation_type]).to eq({
          "id" => biography.id.to_s,
          "firstName" => "Updated First",
          "lastName" => "Updated Last",
          "fullLegalName" => "Updated Full Legal",
          "phoneNumber" => "1233455566",
          "email" => "updated@email.com",
          "street" => "Updated Street",
          "city" => "Updated City",
          "state" => "A New State",
          "zip" => "109876",
          "ssn" => "876998789"
          })
      end
    end

    context 'sad path where user input is missing required parameters' do
      before do
        mutation mutation_string,
          variables: {
            input: {
              name: "Invalid input biography"
            }
          }
      end

      it 'should return errors' do
        expect(gql_response.errors).to be_truthy
      end
    end
  end
end
