class AddPermanentToContacts < ActiveRecord::Migration[6.1]
  def change
    add_column :contacts, :permanent, :boolean, default: true
  end
end
