class CreatePassports < ActiveRecord::Migration[6.1]
  def change
    create_table :passports do |t|
      t.string :passport_number
      t.string :surname
      t.string :given_names
      t.string :nationality
      t.string :birth_place
      t.date :birthdate
      t.date :expiration_date
      t.date :issue_date
      t.integer :passport_sex

      t.timestamps
    end
  end
end
