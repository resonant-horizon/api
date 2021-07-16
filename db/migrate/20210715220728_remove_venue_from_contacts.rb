class RemoveVenueFromContacts < ActiveRecord::Migration[6.1]
  def change
    remove_reference :contacts, :venue, null: false, foreign_key: true
  end
end
