class AddPermanentPartyToContacts < ActiveRecord::Migration[6.1]
  def change
    add_column :contacts, :is_permanent_party, :boolean
  end
end
