class AddVenueToContacts < ActiveRecord::Migration[6.1]
  def change
    add_reference :contacts, :venue, null: false, foreign_key: true
  end
end
