class AddMediaidToMediafiles < ActiveRecord::Migration
  def change
    add_column :mediafiles, :media_id, :int
  end
end
