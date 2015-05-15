class CreateContributions < ActiveRecord::Migration
  def change
    create_table :contributions do |t|
      t.references :user, index: true, foreign_key: true
      t.references :story, index: true, foreign_key: true
      t.text :content

      t.timestamps null: false
    end
  end
end
