class AddOrgToHotels < ActiveRecord::Migration[6.1]
  def change
    add_reference :hotels, :organization, null: false, foreign_key: true
  end
end
