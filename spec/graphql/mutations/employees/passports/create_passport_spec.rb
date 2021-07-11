require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Mutations::Employees::Passports::CreatePassport, type: :request do
  describe 'Creating a passport' do
    let(:user)  { create(:user)  }
    let(:user2) { create(:user) }
    let(:organization) { create(:organization, user: user) }
    let(:employee) {
      create(:employee, organization: organization, user: user2)
    }
    let(:mutation_type) { "createPassport" }
    let(:mutation_string) { <<~GQL
      mutation createPassport($input: CreatePassportInput!) {
        createPassport(input: $input) {
          passportNumber
          surname
          givenNames
          nationality
          birthPlace
          birthdate
          expirationDate
          issueDate
          passportSex
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
              passportNumber: "123456678",
              surname: "New name",
              givenNames: "Too many names",
              nationality: "Doggian",
              birthPlace: "Nowhere",
              birthdate: "1986-03-22",
              expirationDate: "2025-02-02",
              issueDate: "2015-02-02",
              passportSex: "male"
            }
          }
        end

        it 'should return no errors' do
          expect(gql_response.errors).to be_nil
        end

        it 'should return the biography object' do
          expect(gql_response.data[mutation_type]).to eq({
            "passportNumber" => "123456678",
            "surname" => "New name",
            "givenNames" => "Too many names",
            "nationality" => "Doggian",
            "birthPlace" => "Nowhere",
            "birthdate" => "1986-03-22",
            "expirationDate" => "2025-02-02",
            "issueDate" => "2015-02-02",
            "passportSex" => "male",
            "employee" =>
                {
                  "id" => Passport.last.employee.id.to_s
                }
            })
        end
      end

    context 'sad path where user input is missing required parameters' do
      before do
        mutation mutation_string,
          variables: {
            input: {
              id: "Invalid input for passport",
            }
          }
      end

      it 'should return errors' do
        expect(gql_response.errors).to be_truthy
      end
    end
  end
end
