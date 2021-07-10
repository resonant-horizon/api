class AddInstrumentSectionAndEmploymentStatusToEmployees < ActiveRecord::Migration[6.1]
  def change
    add_column :employees, :instrument_section, :integer, null: false
    add_column :employees, :employment_status, :integer, null: false
  end
end
