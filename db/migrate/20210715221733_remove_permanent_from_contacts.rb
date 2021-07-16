class RemovePermanentFromContacts < ActiveRecord::Migration[6.1]
  def change
    remove_column :contacts, :permanent, :boolean
  end
end
