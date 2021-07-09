require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Types::QueryType, type: :request do
  describe 'get employees' do
    let(:user) { create(:user) }
    let(:organization) { create(:organization, user: user) }
    let(:user2) { create(:user) }
    let(:organization2) { create(:organization, user: user2) }
    let(:full_employee) { create(:employee_with_all_data, organization: organization) }
    let(:full_employee2) { create(:employee_with_all_data, organization: organization2, user: user2) }

    let(:query_type_one) { "employee" }
    let(:query_string_one) { <<~GQL
      query employee($id: ID!) {
        employee(id: $id) {
          id
          employmentStatus
          instrumentSection
          substitute
          unionDesignee
          archived
          roles {
            name
          }
          biography {
            firstName
            lastName
            phoneNumber
            email
            fullLegalName
            street
            city
            state
            zip
            ssn
          }
          traveler {
            seatPreference
            americanFf
            deltaFf
            unitedFf
          }
          passport {
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
      }
    GQL
    }
    context 'get one employee' do
      before do
        organization
        organization2
        full_employee
        full_employee2
        query query_string_one, variables: { id: "#{full_employee.id}" }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return an array of all user organizations objects' do
        expect(gql_response.data[query_type_one]).to be_a Hash
        expect(gql_response.data[query_type_one]).to eq({
          "id" => full_employee.id.to_s,
          "employmentStatus" => full_employee.employment_status,
          "instrumentSection" => full_employee.instrument_section,
          "substitute" => full_employee.substitute,
          "unionDesignee" => full_employee.union_designee,
          "archived" => full_employee.archived,
          "roles" => [{
            "name" => full_employee.roles.first.name}],
          "biography" => {
            "firstName" => full_employee.biography.first_name,
            "lastName" => full_employee.biography.last_name,
            "phoneNumber" => full_employee.biography.phone_number ,
            "email" => full_employee.biography.email,
            "fullLegalName" => full_employee.biography.full_legal_name,
            "street" => full_employee.biography.street,
            "city" => full_employee.biography.city,
            "state" => full_employee.biography.state,
            "zip" => full_employee.biography.zip,
            "ssn" => full_employee.biography.ssn,
          },
          "traveler" => {
            "seatPreference" => full_employee.traveler.seat_preference,
            "americanFf" => full_employee.traveler.american_ff,
            "deltaFf" => full_employee.traveler.delta_ff,
            "unitedFf" => full_employee.traveler.united_ff,
          },
          "passport" => {
            "passportNumber" => full_employee.passport.passport_number,
            "surname" => full_employee.passport.surname,
            "givenNames" => full_employee.passport.given_names,
            "nationality" => full_employee.passport.nationality,
            "birthPlace" => full_employee.passport.birth_place,
            "birthdate" => full_employee.passport.birthdate.to_s,
            "expirationDate" => full_employee.passport.expiration_date.to_s,
            "issueDate" => full_employee.passport.issue_date.to_s,
            "passportSex" => full_employee.passport.passport_sex,
          }
        })
      end
    end
  end
end
