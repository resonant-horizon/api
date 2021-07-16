class RemoveTypeFromContacts < ActiveRecord::Migration[6.1]
  def change
    remove_column :contacts, :type, :integer
  end
end
