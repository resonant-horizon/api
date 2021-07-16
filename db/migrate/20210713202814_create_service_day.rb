class CreateServiceDay < ActiveRecord::Migration[6.1]
  def change
    create_table :service_days do |t|
      t.integer :type
      t.date :date
      t.references :workable, polymorphic: true

      t.timestamps
    end
  end
end
