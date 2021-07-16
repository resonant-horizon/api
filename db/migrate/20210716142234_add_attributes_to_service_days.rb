class AddAttributesToServiceDays < ActiveRecord::Migration[6.1]
  def change
    add_column :service_days, :date, :date, null: false
    add_column :service_days, :has_rehearsal, :boolean, default: false
    add_column :service_days, :has_concert, :boolean, default: false
    add_column :service_days, :has_loadin, :boolean, default: false
    add_column :service_days, :has_loadout, :boolean, default: false
  end
end
