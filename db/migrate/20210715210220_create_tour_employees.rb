class CreateTourEmployees < ActiveRecord::Migration[6.1]
  def change
    create_table :tour_employees do |t|
      t.references :tour, null: false, foreign_key: true
      t.references :employee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
