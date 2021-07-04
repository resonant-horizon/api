module Mutations
  module Organizations
    class UpdateOrganization < ::Mutations::BaseMutation
      argument :id, ID, required: true
      argument :name, String, required: false
      argument :user_id, ID, required: false
      argument :contact_name, String, required: false
      argument :phone_number, String, required: false
      argument :contact_email, String, required: false
      argument :street_address, String, required: false
      argument :city, String, required: false
      argument :state, String, required: false
      argument :zip, String, required: false

      type Types::OrganizationType

      def resolve(id:, **attributes)
        Organization.find(id).tap do |org|
          org.update!(attributes)
        end
      end
    end
  end
end
