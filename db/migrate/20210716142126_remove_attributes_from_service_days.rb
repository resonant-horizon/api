class RemoveAttributesFromServiceDays < ActiveRecord::Migration[6.1]
  def change
    remove_column :service_days, :type, :integer
    remove_column :service_days, :date, :date
  end
end
