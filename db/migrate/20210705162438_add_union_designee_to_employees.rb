class AddUnionDesigneeToEmployees < ActiveRecord::Migration[6.1]
  def change
    add_column :employees, :union_designee, :boolean, default: false
  end
end
