class ChangeWorkableNullOnServiceDays < ActiveRecord::Migration[6.1]
  def change
    change_column_null :service_days, :workable_id, false
    change_column_null :service_days, :workable_type, false
  end
end
