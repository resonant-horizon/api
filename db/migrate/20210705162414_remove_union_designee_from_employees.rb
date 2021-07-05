class RemoveUnionDesigneeFromEmployees < ActiveRecord::Migration[6.1]
  def change
    remove_column :employees, :union_designee, :boolean
  end
end
