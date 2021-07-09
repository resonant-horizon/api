class AddEmployeeToBiographies < ActiveRecord::Migration[6.1]
  def change
    add_reference :biographies, :employee, null: false, foreign_key: true
  end
end
