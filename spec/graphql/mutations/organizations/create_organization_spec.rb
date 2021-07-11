require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Mutations::Organizations::CreateOrganization, type: :request do
  describe 'creating an organization' do
    let(:user) { create(:user) }
    let(:mutation_type) { "createOrganization" }
    let(:mutation_string) { <<~GQL
      mutation createOrganization($input: CreateOrganizationInput!) {
        createOrganization(input: $input) {
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
    context 'happy path' do
      before do
        mutation mutation_string,
          variables: {
            input: {
              userId: user.id,
              name: "LAMC",
              contactName: "Sahundra Beans",
              contactEmail: "sb@123.com",
              phoneNumber: "3214568899",
              streetAddress: "1 Best Choir Rd.",
              city: "Los Angeles",
              state: "CA",
              zip: "78200"
            }
          }
        end

        it 'creates an organization' do
          expect(Organization.count).to eq(1)
        end

        it 'returns an organization' do
          data = gql_response.data["createOrganization"]

          expect(data).to include(
            "id" => "#{Organization.first.id}",
            "name" => "LAMC",
            "contactName" => "Sahundra Beans",
            "contactEmail" => "sb@123.com",
            "phoneNumber" => "3214568899",
            "streetAddress" => "1 Best Choir Rd.",
            "city" => "Los Angeles",
            "state" => "CA",
            "zip" => "78200",
            "user" => { "id" => user.id.to_s }
          )
        end
      end

    context 'sad path' do
      before do
        mutation mutation_string,
          variables: {
            input: {
              var: "Invalid input for org creation"
            }
          }
      end

      it 'should return errors' do
        expect(gql_response.errors).to be_truthy
      end
    end
  end
end
