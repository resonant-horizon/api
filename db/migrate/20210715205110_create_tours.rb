class CreateTours < ActiveRecord::Migration[6.1]
  def change
    create_table :tours do |t|
      t.references :organization, null: false, foreign_key: true
      t.string :name, null: false
      t.string :description
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.boolean :is_archived, default: false
      t.boolean :is_international, default: false

      t.timestamps
    end
  end
end
