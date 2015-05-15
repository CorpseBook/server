class Location < ActiveRecord::Base
	
	belongs_to :locatable, :polymorphic => true
	acts_as_mappable :default_units => :kms,
						:lat_column_name => :lat,
						:lng_column_name => :lng
end


