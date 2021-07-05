class AddEmployeeToPassports < ActiveRecord::Migration[6.1]
  def change
    add_reference :passports, :employee, null: false, foreign_key: true
  end
end
