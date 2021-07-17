class RemoveArchivedFromSeasons < ActiveRecord::Migration[6.1]
  def change
    remove_column :seasons, :archived, :boolean
    add_column :seasons, :is_archived, :boolean, default: false
  end
end
