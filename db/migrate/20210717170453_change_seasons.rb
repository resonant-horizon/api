class ChangeSeasons < ActiveRecord::Migration[6.1]
  def change
    change_column_null :seasons, :description, true
  end
end
