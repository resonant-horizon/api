require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Types::QueryType, type: :request do
  describe 'get users' do
    let(:user) { create(:user) }
    let(:organization) { create(:organization, user: user) }
    let(:user2) { create(:user) }
    let(:organization2) { create(:organization, user: user2) }
    let(:basic_employee) { create(:employee, organization: organization) }
    let(:basic_employee2) { create(:employee, organization: organization2) }
    let(:full_employee) { create(:employee_with_all_data, organization: organization) }
    let(:full_employee2) { create(:employee_with_all_data, organization: organization2) }

    let(:query_type_user_orgs) { "userOrganizations" }
    let(:query_user_orgs) { <<~GQL
        query user($id: ID!) {
          user(id: $id) {
            firstName
            lastName
            email
            phoneNumber
            id
            organizations {
              id
              name
              contactName
              contactEmail
              phoneNumber
              streetAddress
              city
              state
              zip
            }
          }
        }
    GQL
    }
    let(:query_type_one) { "organization" }
    let(:query_string_one) { <<~GQL
      query organization($id: ID!) {
        organization(id: $id) {
          id
          name
          contactName
          contactEmail
          phoneNumber
          streetAddress
          city
          state
          zip
          user {
            id
          }
        }
      }
    GQL
    }
    let(:query_type_all) { "organizations" }
    let(:query_string_all) { <<~GQL
        {
          organizations {
            id
            name
            contactName
            contactEmail
            phoneNumber
            streetAddress
            city
            state
            zip
            user {
              firstName
              lastName
              email
              phoneNumber
              id
            }
          }
        }
      GQL
      }

  let(:query_type_employees) { "org employees"}
  let(:query_string_employees) { <<~GQL
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
#   employees {
#     id
#     biography {
#       id
#       firstName
#       lastName
#       phoneNumber
#       email
#       fullLegalName
#       street
#       city
#       state
#       zip
#       ssn
#     }
#     traveler {
#       seatPreference
#       americanFf
#       deltaFf
#       unitedFf
#     }
#     passport {
#       passportNumber
#       surname
#       given_names
#       nationality
#       birthPlace
#       birthdate
#       expirationDate
#       issueDate
#       birthdate
#       birthCity
#       nationality
#       passportSex
#     }
#     employmentStatus
#     instrumentSection
#     role {
#       name
#     }
#     substitute
#     unionDesignee
#     archived
#   }
# }
    context 'get all organizations' do
      before do
        organization
        query query_string_all
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return an array of all user organizations objects' do
        expect(gql_response.data[query_type_all]).to be_an Array
        expect(gql_response.data[query_type_all].first).to eq({
          "id" => organization.id.to_s,
          "name" => organization.name,
          "contactName" => organization.contact_name,
          "contactEmail" => organization.contact_email,
          "phoneNumber" => organization.phone_number,
          "city" => organization.city,
          "state" => organization.state,
          "streetAddress" => organization.street_address,
          "zip" => organization.zip,
          "user" => {
            "id" => user.id.to_s,
            "firstName" => user.first_name,
            "lastName" => user.last_name,
            "email" => user.email,
            "phoneNumber" => user.phone_number
          }
        })
      end
    end

    context 'Get All Organizations for a user' do

      before do
        user
        user2
        organization
        organization2
        query query_user_orgs, variables: { id: "#{user.id}" }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return an array of all user organizations objects' do
        expect(gql_response.data["user"]["organizations"]).to be_an Array
        expect(gql_response.data["user"]["organizations"]).to eq([{
          "id" => organization.id.to_s,
          "name" => organization.name,
          "contactName" => organization.contact_name,
          "contactEmail" => organization.contact_email,
          "phoneNumber" => organization.phone_number,
          "city" => organization.city,
          "state" => organization.state,
          "streetAddress" => organization.street_address,
          "zip" => organization.zip
        }])
        expect(gql_response.data["user"]["id"]).to_not eq(user2.id)
      end
    end

    context 'Get Organization' do
      before do
        organization
        query query_string_one,
          variables: {
            id: organization.id
          }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return one organization object' do
        expect(gql_response.data[query_type_one]).to be_a Hash
        expect(gql_response.data[query_type_one]).to eq({
          "id" => organization.id.to_s,
          "name" => organization.name,
          "contactName" => organization.contact_name,
          "contactEmail" => organization.contact_email,
          "phoneNumber" => organization.phone_number,
          "city" => organization.city,
          "state" => organization.state,
          "streetAddress" => organization.street_address,
          "zip" => organization.zip,
          "user" => {
            "id" => user.id.to_s
          }
        })
      end
    end

    context 'employees for an organization' do
      before do
        organization
        organization2
        basic_employee
        basic_employee2
        query query_string_employees,
          variables: {
            id: organization.id
          }
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'should return employees for an organization' do
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
  end
end
