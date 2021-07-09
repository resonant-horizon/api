class AddUserToEmployees < ActiveRecord::Migration[6.1]
  def change
    add_reference :employees, :user, null: false, foreign_key: true
  end
end
