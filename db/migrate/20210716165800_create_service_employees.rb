class CreateServiceEmployees < ActiveRecord::Migration[6.1]
  def change
    create_table :service_employees do |t|
      t.references :service_day, null: false, foreign_key: true
      t.references :employee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
