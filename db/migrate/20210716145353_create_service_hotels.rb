class CreateServiceHotels < ActiveRecord::Migration[6.1]
  def change
    create_table :service_hotels do |t|
      t.references :hotel, null: false, foreign_key: true
      t.references :service_day, null: false, foreign_key: true

      t.timestamps
    end
  end
end
