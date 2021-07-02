class CreateEmployees < ActiveRecord::Migration[6.1]
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.string :email
      t.string :full_legal_name
      t.string :street
      t.string :city
      t.string :state
      t.string :zip
      t.string :ssn
      t.string :passport_number
      t.date :passport_issue_date
      t.date :passport_expiration
      t.date :birthdate
      t.string :birth_city
      t.string :nationality
      t.integer :passport_sex
      t.string :american_frequent_flyer
      t.string :delta_frequent_flier
      t.string :united_frequent_flyer
      t.references :organization, null: false, foreign_key: true
      t.boolean :union_designee
      t.integer :employment_status

      t.timestamps
    end
  end
end
