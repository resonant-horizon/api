require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Types::QueryType, type: :request do
  describe 'get employees' do
    let(:user) { create(:user) }
    let(:organization) { create(:organization, user: user) }
    let(:user2) { create(:user) }
    let(:organization2) { create(:organization, user: user2) }
    let(:employee) { create(:employee_with_all_data, organization: organization) }
    let(:employee2) { create(:employee_with_all_data, organization: organization2, user: user2) }
    let(:query_type_org_employees) { "org employees" }
    let(:query_org_employees) { <<~GQL
        query organization($id: ID!) {
          organization(id: $id) {
            name
            id
            employees {
              id
              biography {
                id
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
                given_names
                nationality
                birthPlace
                birthdate
                expirationDate
                issueDate
                birthdate
                birthCity
                nationality
                passportSex
              }
              employmentStatus
              instrumentSection
              role {
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
    let(:query_type_one) { "employee" }
    let(:query_string_one) { <<~GQL
      query employee($id: ID!) {
        employee(id: $id) {
          id
          biography {
            id
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
            given_names
            nationality
            birthPlace
            birthdate
            expirationDate
            issueDate
            birthdate
            birthCity
            nationality
            passportSex
          }
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
    GQL
    }
    let(:query_type_all) { "employees" }
    let(:query_string_all) { <<~GQL
        {
          employees {
            id
            biography {
              id
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
              given_names
              nationality
              birthPlace
              birthdate
              expirationDate
              issueDate
              birthdate
              birthCity
              nationality
              passportSex
            }
            employmentStatus
            instrumentSection
            role {
              name
            }
            substitute
            unionDesignee
            archived
          }
        }
      GQL
      }

    context 'get all employees' do
      before do
        employee
        employee2
        query query_string_all
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return an array of all user organizations objects' do
        expect(gql_response.data[query_type_all]).to be_an Array
        expect(gql_response.data[query_type_all].first).to eq({
          "id" => employee.id.to_s,
          "biography" => {
            "id" => employee.biography.id.to_s,
            "firstName" => employee.first_name,
            "lastName" => employee.last_name,
            "phoneNumber" => employee.phone_number,
            "email" => employee.email,
            "fullLegalName" => employee.full_legal_name,
            "street" => employee.street,
            "city" => employee.city,
            "state" => employee.state,
            "zip" => employee.zip,
            "ssn" => employee.ssn,
          },
          "traveler" => {
            "seatPreference" => employee.traveler.seat_preference,
            "americanFf" => employee.traveler.american_ff,
            "deltaFf" => employee.traveler.delta_ff,
            "unitedFf" => employee.traveler.united_ff
          },
          "passport" => {
            "passportNumber" => employee.passport.passport_number,
            "issueDate" => employee.passport.issue_date,
            "expirationDate" => employee.passport.expiration_date,
            "birthdate" => employee.passport.birthdate,
            "birthPlace" => employee.passport.birth_place,
            "nationality" => employee.passport.nationality,
            "passportSex" => employee.passport.passport_sex,
            "surname" => employee.passport.surname,
            "given_names" => employee.passport.given_names
          },
          "employmentStatus" => employee.employment_status,
          "instrumentSection" => employee.instrument_section,
          "substitute" => employee.substitute,
          "unionDesignee" => employee.union_designee,
          "archived" => employee.archived,
          "roles" => {
            "names" => employee.roles
          }
        })
      end
    end


    # context 'Get All Organizations for a user' do
    #
    #   before do
    #     user
    #     user2
    #     organization
    #     organization2
    #     query query_user_orgs, variables: { id: "#{user.id}" }
    #   end
    #
    #   it 'should return no errors' do
    #     expect(gql_response.errors).to be_nil
    #   end
    #
    #   it 'should return an array of all user organizations objects' do
    #     expect(gql_response.data["user"]["organizations"]).to be_an Array
    #     expect(gql_response.data["user"]["organizations"]).to eq([{
    #       "id" => organization.id.to_s,
    #       "name" => organization.name,
    #       "contactName" => organization.contact_name,
    #       "contactEmail" => organization.contact_email,
    #       "phoneNumber" => organization.phone_number,
    #       "city" => organization.city,
    #       "state" => organization.state,
    #       "streetAddress" => organization.street_address,
    #       "zip" => organization.zip
    #     }])
    #     expect(gql_response.data["user"]["id"]).to_not eq(user2.id)
    #   end
    # end
    #
    # context 'Get Organization' do
    #   before do
    #     organization
    #     query query_string_one,
    #       variables: {
    #         id: organization.id
    #       }
    #   end
    #
    #   it 'should return no errors' do
    #     expect(gql_response.errors).to be_nil
    #   end
    #
    #   it 'should return one organization object' do
    #     expect(gql_response.data[query_type_one]).to be_a Hash
    #     expect(gql_response.data[query_type_one]).to eq({
    #       "id" => organization.id.to_s,
    #       "name" => organization.name,
    #       "contactName" => organization.contact_name,
    #       "contactEmail" => organization.contact_email,
    #       "phoneNumber" => organization.phone_number,
    #       "city" => organization.city,
    #       "state" => organization.state,
    #       "streetAddress" => organization.street_address,
    #       "zip" => organization.zip,
    #       "user" => {
    #         "id" => user.id.to_s
    #       }
    #     })
    #   end
    # end
  end
end
