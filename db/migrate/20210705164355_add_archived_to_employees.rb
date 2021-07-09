class AddArchivedToEmployees < ActiveRecord::Migration[6.1]
  def change
    add_column :employees, :archived, :boolean, default: false
  end
end
