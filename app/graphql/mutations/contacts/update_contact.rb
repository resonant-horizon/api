module Mutations
  module Contacts
    class UpdateContact < ::Mutations::BaseMutation
      argument :id,                   ID,     required: true
      argument :name,                 String, required: false
      argument :phone_number,         String, required: false
      argument :email,                String, required: false
      argument :description,          String, required: false
      argument :role,                 String, required: false
      argument :is_permanent_party,   Boolean,required: false

      type Types::ContactType

      def resolve(id:, **attributes)
        Contact.find(id).tap do |contact|
          contact.update!(attributes)
        end
      end
    end
  end
end
