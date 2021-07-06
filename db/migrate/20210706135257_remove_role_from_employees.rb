class RemoveRoleFromEmployees < ActiveRecord::Migration[6.1]
  def change
    remove_column :employees, :role, :integer
  end
end
