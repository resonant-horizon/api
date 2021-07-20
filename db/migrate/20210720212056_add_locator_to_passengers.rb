class AddLocatorToPassengers < ActiveRecord::Migration[6.1]
  def change
    add_column :passengers, :locator, :string, null: false
  end
end
