class RemoveDeltaFrequentFlierFromEmployees < ActiveRecord::Migration[6.1]
  def change
    remove_column :employees, :delta_frequent_flier, :string
  end
end
