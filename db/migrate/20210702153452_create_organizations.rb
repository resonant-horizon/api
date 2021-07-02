class CreateOrganizations < ActiveRecord::Migration[6.1]
  def change
    create_table :organizations do |t|
      t.string :name, null: false
      t.string :contact_name, null: false
      t.string :contact_email, null: false
      t.string :phone_number, null: false
      t.string :street_address, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.string :zip, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
