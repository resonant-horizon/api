class RemoveAttributesFromEmployees < ActiveRecord::Migration[6.1]
  def change
    remove_column :employees, :first_name, :string
    remove_column :employees, :last_name, :string
    remove_column :employees, :full_legal_name, :string
    remove_column :employees, :phone_number, :string
    remove_column :employees, :email, :string
    remove_column :employees, :street, :string
    remove_column :employees, :city, :string
    remove_column :employees, :state, :string
    remove_column :employees, :zip, :string
    remove_column :employees, :ssn, :string
    remove_column :employees, :birthdate, :date
    remove_column :employees, :birth_city, :string
    remove_column :employees, :nationality, :string
    remove_column :employees, :passport_sex, :integer
    remove_column :employees, :american_frequent_flyer, :string
    remove_column :employees, :united_frequent_flyer, :string
    remove_column :employees, :delta_frequent_flyer, :string
  end
end
