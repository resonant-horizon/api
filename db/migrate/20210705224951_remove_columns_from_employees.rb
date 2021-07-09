class RemoveColumnsFromEmployees < ActiveRecord::Migration[6.1]
  def change
    remove_reference :employees, :biography, null: false, foreign_key: true
    remove_reference :employees, :passport, null: false, foreign_key: true
    remove_reference :employees, :traveler, null: false, foreign_key: true
  end
end
