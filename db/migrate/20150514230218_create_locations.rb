class CreateLocations < ActiveRecord::Migration
	def change
		create_table :locations do |t|

			t.float :lat
			t.float :lng
			t.references :locatable, polymorphic: true, index: true 

			t.timestamps null: false
		end
	end
end
