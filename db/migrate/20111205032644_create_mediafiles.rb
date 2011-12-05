class CreateMediafiles < ActiveRecord::Migration
  def change
    create_table :mediafiles do |t|
      t.string :title
      t.string :filename
      t.string :relativepath

      t.timestamps
    end
  end
end
