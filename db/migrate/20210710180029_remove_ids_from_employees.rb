class RemoveIdsFromEmployees < ActiveRecord::Migration[6.1]
  def change
    remove_reference :employees, :passport, foreign_key: true
    remove_reference :employees, :biography, foreign_key: true
    remove_reference :employees, :traveler, foreign_key: true
  end
end
