require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Mutations::Employees::Biographies::CreateBiography, type: :request do
  describe 'Creating a biography' do
    let(:user)  { create(:user)  }
    let(:user2) { create(:user) }
    let(:organization) { create(:organization, user: user) }
    let(:employee) {
      create(:employee, organization: organization, user: user2)
    }
    let(:mutation_type) { "createBiography" }
    let(:mutation_string) { <<~GQL
      mutation createBiography($input: CreateBiographyInput!) {
        createBiography(input: $input) {
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
              firstName: "New first",
              lastName: "new last",
              fullLegalName: "new full",
              phoneNumber: "I gotta new phone",
              email: "toonew@g.com",
              street: "New Street",
              city: "New city even",
              state: "WV",
              zip: "789999",
              ssn: "123456789"
            }
          }
        end
        it 'should return no errors' do
          expect(gql_response.errors).to be_nil
        end

        it 'should return the biography object' do
          expect(gql_response.data[mutation_type]).to eq({
            "firstName" => "New first",
            "lastName" => "new last",
            "fullLegalName" => "new full",
            "phoneNumber" => "I gotta new phone",
            "email" => "toonew@g.com",
            "street" => "New Street",
            "city" => "New city even",
            "state" => "WV",
            "zip" => "789999",
            "ssn" => "123456789",
            "employee" =>
                {
                  "id" => Biography.last.employee_id.to_s
                }
            })
        end
      end

    context 'sad path where user input is missing required parameters' do
      before do
        mutation mutation_string,
          variables: {
            input: {
              id: "Invalid input for biography",
            }
          }
      end

      it 'should return errors' do
        expect(gql_response.errors).to be_truthy
      end
    end
  end
end
