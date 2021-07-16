class AddTravelToServiceDays < ActiveRecord::Migration[6.1]
  def change
    add_column :service_days, :has_travel, :boolean, default: false
  end
end
