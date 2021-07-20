class AddOrgToVenues < ActiveRecord::Migration[6.1]
  def change
    add_reference :venues, :organization, null: false, foreign_key: true
  end
end
