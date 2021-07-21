class Contact < ApplicationRecord
  belongs_to :contactable, polymorphic: true
  belongs_to :organization

  validates_presence_of :name,
                        :phone_number,
                        :email,
                        :organization_id
end
