class AddUseridToMediafiles < ActiveRecord::Migration
  def change
    add_column :mediafiles, :user_id, :int, :default => 0
  end
end
