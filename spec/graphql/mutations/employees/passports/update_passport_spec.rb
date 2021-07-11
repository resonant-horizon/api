require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Mutations::Employees::Passports::UpdatePassport, type: :request do
  describe 'Updating a passport' do

    let(:user) { create(:user) }
    let(:organization) { create(:organization, user: user) }
    let(:employee) { create(:employee, user: user, organization: organization) }
    let(:passport) { create(:passport, employee: employee) }
    let(:mutation_type) { "updatePassport" }
    let(:mutation_string) { <<~GQL
      mutation updatePassport($input: UpdatePassportInput!) {
        updatePassport(input: $input) {
          id
          passportNumber
          surname
          givenNames
          nationality
          birthPlace
          birthdate
          expirationDate
          issueDate
          passportSex
        }
      }
    GQL
    }

    context 'happy path' do

      before do
        mutation mutation_string,
          variables: {
            input: {
              id: passport.id,
              passportNumber: "183939939",
              surname: "Updated Surname",
              givenNames: "Updated Given",
              nationality: "Updated nationality",
              birthPlace: "Updated Birthplace",
              birthdate: "1993-02-23",
              expirationDate: "2030-01-01",
              issueDate: "2020-01-01",
              passportSex: "male"
            }
          }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return the SubEvent object' do
        expect(gql_response.data[mutation_type]).to eq({
          "id" => passport.id.to_s,
          "passportNumber" => "183939939",
          "surname" => "Updated Surname",
          "givenNames" => "Updated Given",
          "nationality" => "Updated nationality",
          "birthPlace" => "Updated Birthplace",
          "birthdate" => "1993-02-23",
          "expirationDate" => "2030-01-01",
          "issueDate" => "2020-01-01",
          "passportSex" => "male"
          })
      end
    end

    context 'sad path where user input is missing required parameters' do
      before do
        mutation mutation_string,
          variables: {
            input: {
              name: "Invalid input passport"
            }
          }
      end

      it 'should return errors' do
        expect(gql_response.errors).to be_truthy
      end
    end
  end
end
