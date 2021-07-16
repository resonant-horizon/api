class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.string :description
      t.datetime :start_time, null: false
      t.datetime :end_time
      t.string :notes
      t.references :service_day, null: false, foreign_key: true

      t.timestamps
    end
  end
end
