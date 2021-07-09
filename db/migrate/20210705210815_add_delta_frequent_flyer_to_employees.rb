class AddDeltaFrequentFlyerToEmployees < ActiveRecord::Migration[6.1]
  def change
    add_column :employees, :delta_frequent_flyer, :string
  end
end
