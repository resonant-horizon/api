class RemovePassportsFromEmployees < ActiveRecord::Migration[6.1]
  def change
    remove_column :employees, :passport_number, :string
    remove_column :employees, :passport_issue_date, :date
    remove_column :employees, :passport_expiration, :date
  end
end
