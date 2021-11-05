module Mutations
  module Contacts
    class DestroyContact < ::Mutations::BaseMutation
      argument :id, Integer, required: true

      type Types::ContactType

      def resolve(id:)
        Contact.find(id).destroy
      end
    end
  end
end
