class ChangeColumnsonHotels < ActiveRecord::Migration[6.1]
  def change
    change_column_null :hotels, :name, false
    change_column_null :hotels, :street, false
    change_column_null :hotels, :city, false
    change_column_null :hotels, :state, false
    change_column_null :hotels, :zip, false
    change_column_null :hotels, :country, false
  end
end
