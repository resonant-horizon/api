require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Types::QueryType, type: :request do
  describe 'get organizations' do
    let(:user) { create(:user) }
    let(:organization) { create(:organization, user: user) }
    let(:user2) { create(:user) }
    let(:organization2) { create(:organization, user: user2) }
    let(:basic_employee) { create(:employee, organization: organization) }
    let(:basic_employee2) { create(:employee, organization: organization2) }
    let(:full_employee) { create(:employee_with_all_data, organization: organization) }
    let(:full_employee2) { create(:employee_with_all_data, organization: organization2) }

    let(:query_type_basic_employees) { "org employees"}
    let(:query_string_basic_employees) { <<~GQL
      query organization($id: ID!) {
        organization(id: $id) {
          id
          name
          user {
            id
          }
          employees {
            id
            employmentStatus
            instrumentSection
            roles {
              name
            }
            substitute
            unionDesignee
            archived
          }
        }
      }
    GQL
    }

    let(:query_type_full_employees) { "org employees"}
    let(:query_string_full_employees) { <<~GQL
      query organization($id: ID!) {
        organization(id: $id) {
          id
          employees {
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
      }
    GQL
    }

    context 'employees for an organization' do
      describe 'basic employees'
        before do
          organization
          organization2
          basic_employee
          basic_employee2
          query query_string_basic_employees,
            variables: {
              id: organization.id
            }
        end

        it 'should return no errors' do
          expect(gql_response.errors).to be_nil
        end

        it 'should return basic employees for an organization' do
          expect(gql_response.data["organization"]["employees"]).to be_an(Array)
          expect(gql_response.data["organization"]["employees"]).to eq([{
              "id" => basic_employee.id.to_s,
              "employmentStatus" => basic_employee.employment_status,
              "instrumentSection" => basic_employee.instrument_section,
              "roles" => basic_employee.roles,
              "substitute" => basic_employee.substitute,
              "unionDesignee" =>  basic_employee.union_designee,
              "archived" => basic_employee.archived
          }])
        end
      end

      describe 'full employees' do
        before do
          full_employee
          full_employee2
          query query_string_full_employees,
            variables: {
              id: organization.id
            }
        end

        it 'should return no errors' do
          expect(gql_response.errors).to be_nil
        end

        it 'should return full employees for an organization' do
          expect(gql_response.data["organization"]["employees"]).to be_an(Array)
          expect(gql_response.data["organization"]["employees"]).to eq([{
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
            }])
        expect(gql_response.data["organization"]["employees"].first["id"]).to_not eq(full_employee2.id.to_s)
      end
    end
  end
end
