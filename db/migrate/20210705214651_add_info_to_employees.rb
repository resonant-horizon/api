class AddInfoToEmployees < ActiveRecord::Migration[6.1]
  def change
    add_reference :employees, :biography, null: false, foreign_key: true
    add_reference :employees, :passport, null: false, foreign_key: true
    add_reference :employees, :traveler, null: false, foreign_key: true
  end
end
