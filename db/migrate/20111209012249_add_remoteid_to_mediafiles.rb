class AddRemoteidToMediafiles < ActiveRecord::Migration
  def up
    add_column :mediafiles, :remote_id, :int, :default => 0
  end
  def down
    remove_column :mediafiles, :remote_id
  end
end
