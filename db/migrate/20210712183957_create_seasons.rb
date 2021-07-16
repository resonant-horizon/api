class CreateSeasons < ActiveRecord::Migration[6.1]
  def change
    create_table :seasons do |t|
      t.references :organization, null: false, foreign_key: true
      t.string :name, null: false
      t.string :description, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.boolean :archived, default: false

      t.timestamps
    end
  end
end
