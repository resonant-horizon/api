class AddColumnsToEmployees < ActiveRecord::Migration[6.1]
  def change
    add_reference :employees, :passport, foreign_key: true
    add_reference :employees, :biography, foreign_key: true
    add_reference :employees, :traveler, foreign_key: true
  end
end
