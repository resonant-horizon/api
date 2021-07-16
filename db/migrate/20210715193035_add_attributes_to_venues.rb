class AddAttributesToVenues < ActiveRecord::Migration[6.1]
  def change
    add_column :venues, :name, :string, null: false
    add_column :venues, :street, :string, null: false
    add_column :venues, :city, :string, null: false
    add_column :venues, :state, :string, null: false
    add_column :venues, :zip, :string, null: false
    add_column :venues, :country, :string, null: false
    add_column :venues, :capacity, :integer
  end
end
