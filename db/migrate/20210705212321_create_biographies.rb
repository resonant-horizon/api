class CreateBiographies < ActiveRecord::Migration[6.1]
  def change
    create_table :biographies do |t|
      t.string :first_name
      t.string :last_name
      t.string :full_legal_name
      t.string :phone_number
      t.string :email
      t.string :street
      t.string :city
      t.string :state
      t.string :zip
      t.string :ssn

      t.timestamps
    end
  end
end
