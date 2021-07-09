class AddInstrumentSectionAndRoleToEmployees < ActiveRecord::Migration[6.1]
  def change
    add_column :employees, :instrument_section, :integer
    add_column :employees, :role, :integer, array: true, default: []
  end
end
