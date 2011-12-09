class RemoveTitleFromMediafiles < ActiveRecord::Migration
  def up
    remove_column :mediafiles, :title
  end
  def down
    add_column :mediafiles, :title, :string
  end
end
