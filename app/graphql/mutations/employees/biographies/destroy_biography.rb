module Mutations
  module Employees
    module Biographies
      class DestroyBiography < ::Mutations::BaseMutation
        argument :id, ID, required: true

        type Types::BiographyType

        def resolve(id:)
          Biography.find(id).destroy
        end
      end
    end
  end
end
