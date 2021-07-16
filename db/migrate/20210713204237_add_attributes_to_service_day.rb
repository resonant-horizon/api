class AddAttributesToServiceDay < ActiveRecord::Migration[6.1]
  def change
    add_column :service_days, :name, :string
    add_column :service_days, :description, :string
  end
end
