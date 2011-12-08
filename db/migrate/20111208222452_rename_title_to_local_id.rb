class RenameTitleToLocalId < ActiveRecord::Migration
  def up
    remove_column :mediafiles, :title
    add_column :mediafiles, :remote_id, :int, :default => 0
  end
  def down
    add_column :mediafiles, :title, :string
    remove_column :mediafiles, :remote_id
  end
end
