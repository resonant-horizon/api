class Contact < ApplicationRecord
  belongs_to :contactable, polymorphic: true

  validates_presence_of :name,
                        :phone_number,
                        :email,
                        :description,
                        :role,
                        :is_permanent_party
end
