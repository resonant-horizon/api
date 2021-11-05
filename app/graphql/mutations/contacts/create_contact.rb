module Mutations
  module Contacts
    class CreateContact < ::Mutations::BaseMutation
      argument :contactable_id,       ID,     required: true
      argument :contactable_type,     String, required: true
      argument :organization_id,      ID,     required: true

      argument :name,                 String, required: true
      argument :phone_number,         String, required: true
      argument :email,                String, required: true
      argument :description,          String, required: false
      argument :role,                 String, required: false
      argument :is_permanent_party,   Boolean,required: false

      type Types::ContactType

      def resolve(contactable_id:, contactable_type:, **attributes)
        if contactable_type == "Venue"
          Venue.find(contactable_id).contacts.create!(attributes)
        elsif contactable_type == "Hotel"
          Hotel.find(contactable_id).contacts.create!(attributes)
        else
          raise GraphQL::ExecutionError, "Type not valid"
        end
      end

      def contactable_type
        self.constantize
      end
    end
  end
end
