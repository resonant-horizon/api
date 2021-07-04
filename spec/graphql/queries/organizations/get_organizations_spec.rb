require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Types::QueryType, type: :request do
  describe 'get users' do
    let(:user) { create(:user) }
    let(:organization) { create(:organization, user: user) }
    let(:user2) { create(:user) }
    let(:organization2) { create(:organization, user: user2) }
    let(:query_type_all) { "userOrganizations" }
    let(:query_string_all) { <<~GQL
        query userOrganizations($userId: ID!) {
          user(id: $userId) {
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
    context 'Get All Organizations for a user' do

      before do
        user
        user2
        organization
        organization2
        query query_string_all, variables: { userId: "#{user.id}" }
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
  end
end
