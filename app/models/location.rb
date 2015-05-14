class Location < ActiveRecord::Base
	belongs_to :locatable, :polymorphic => true
	acts_as_mappable
end
