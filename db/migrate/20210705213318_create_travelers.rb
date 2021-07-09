class CreateTravelers < ActiveRecord::Migration[6.1]
  def change
    create_table :travelers do |t|
      t.string :delta_ff
      t.string :american_ff
      t.string :united_ff
      t.string :lufthansa_ff
      t.string :british_air_ff
      t.integer :seat_preference
      t.references :employee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
