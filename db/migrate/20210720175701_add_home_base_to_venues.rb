class AddHomeBaseToVenues < ActiveRecord::Migration[6.1]
  def change
    add_column :venues, :is_headquarters, :boolean, default: false
  end
end
