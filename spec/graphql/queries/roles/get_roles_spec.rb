require 'rails_helper'
include GraphQL::TestHelpers

RSpec.describe Types::QueryType, type: :request do
  describe 'get roles' do
    let(:role) { create(:role) }
    let(:query_type_all) { "roles" }
    let(:query_string_all) { <<~GQL
        {
          roles {
            id
            name
            description
          }
        }
        GQL
      }
    context 'all roles available' do
      before do
        role
        query query_string_all
      end

      it 'should return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'can return all roles' do
        expect(gql_response.data[query_type_all]).to be_an Array
        expect(gql_response.data[query_type_all].first).to eq({
          "id" => role.id.to_s,
          "name" => role.name,
          "description" => role.description
        })
      end
    end

    describe 'it can return employees in a specific role' do

    end
  end
end
