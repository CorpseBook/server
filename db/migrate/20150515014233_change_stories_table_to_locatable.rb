class ChangeStoriesTableToLocatable < ActiveRecord::Migration
  change_table :stories do |t|
  	t.remove :origin_latitude
	t.remove :origin_longitude
	t.references :locatable, polymorphic: true, index: true 
  end
end
