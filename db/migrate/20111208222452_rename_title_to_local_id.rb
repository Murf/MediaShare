class RenameTitleToLocalId < ActiveRecord::Migration
  def change
    remove_column :mediafiles, :title
    add_column :mediafiles, :remote_id, :int, :default => 0
  end
end
