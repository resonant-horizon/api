class AddSubstituteToEmployees < ActiveRecord::Migration[6.1]
  def change
    add_column :employees, :substitute, :boolean, default: false
  end
end
