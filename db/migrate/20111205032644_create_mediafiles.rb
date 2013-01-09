class CreateMediafiles < ActiveRecord::Migration
  def change
    create_table :mediafiles do |t|
      t.string :filename
      t.string :relativepath
      t.integer :remote_id
      t.integer :user_id
      t.integer :medium_id
      t.timestamps
    end
    add_index("mediafiles", "user_id")
    add_index("mediafiles", "remote_id")
  end
end
