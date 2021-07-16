class AddContactableToContacts < ActiveRecord::Migration[6.1]
  def change
    add_reference :contacts, :contactable, polymorphic: true, index: true
  end
end
