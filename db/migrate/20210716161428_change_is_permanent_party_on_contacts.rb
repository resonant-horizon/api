class ChangeIsPermanentPartyOnContacts < ActiveRecord::Migration[6.1]
  def change
    change_column_default :contacts, :is_permanent_party, true
  end
end
