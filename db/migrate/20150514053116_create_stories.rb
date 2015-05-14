class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :title
      t.float :origin_latitude
      t.float :origin_longitude
      t.integer :contribution_limit
      t.boolean :completed

      t.timestamps null: false
    end
  end
end
