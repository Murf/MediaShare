class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.string :title
      t.integer :type
      t.string :genre
      t.integer :imdb_id

      t.timestamps
    end
  end
end
