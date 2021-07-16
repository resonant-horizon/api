class RemoveVenuesAttributes < ActiveRecord::Migration[6.1]
  def change
    remove_column :venues, :name, :string
    remove_column :venues, :street, :string
    remove_column :venues, :city, :string
    remove_column :venues, :state, :string
    remove_column :venues, :zip, :string
    remove_column :venues, :capacity, :string
  end
end
