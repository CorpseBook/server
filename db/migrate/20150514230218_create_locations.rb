class CreateLocations < ActiveRecord::Migration
	def change
		create_table :locations do |t|

			t.integer :lat
			t.integer :lng

			t.timestamps null: false
		end
	end
end
