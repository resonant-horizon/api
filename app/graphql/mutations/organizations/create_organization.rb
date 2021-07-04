module Mutations
  module Organizations
    class CreateOrganization < ::Mutations::BaseMutation
      argument :name, String, required: true
      argument :user_id, ID, required: true
      argument :contact_name, String, required: true
      argument :phone_number, String, required: true
      argument :contact_email, String, required: true
      argument :street_address, String, required: true
      argument :city, String, required: true
      argument :state, String, required: true
      argument :zip, String, required: true

      type Types::OrganizationType

      def resolve(user_id:, **attributes)
        User.find(user_id).organizations.create!(attributes)
      end
    end
  end
end
