class RemoveInstrumentSectionAndEmploymentStatusFromEmployees < ActiveRecord::Migration[6.1]
  def change
    remove_column :employees, :instrument_section, :integer
    remove_column :employees, :employment_status, :integer
  end
end
