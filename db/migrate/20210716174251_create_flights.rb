class CreateFlights < ActiveRecord::Migration[6.1]
  def change
    create_table :flights do |t|
      t.integer :airline_network, null: false
      t.integer :airline, null: false
      t.string :flight_number, null: false
      t.datetime :departure_time, null: false
      t.string :departure_airport, null: false
      t.datetime :arrival_time, null: false
      t.string :arrival_airport, null: false
      t.boolean :is_international, default: false
      t.references :service_day, null: false, foreign_key: true

      t.timestamps
    end
  end
end
