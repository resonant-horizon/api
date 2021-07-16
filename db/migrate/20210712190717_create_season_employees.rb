class CreateSeasonEmployees < ActiveRecord::Migration[6.1]
  def change
    create_table :season_employees do |t|
      t.references :employee, null: false, foreign_key: true
      t.references :season, null: false, foreign_key: true

      t.timestamps
    end
  end
end
