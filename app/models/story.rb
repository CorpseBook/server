class Story < ActiveRecord::Base
  has_many :contributions
  has_one :location, as: :locatable  # also works for belongs_to associations
  acts_as_mappable through: :location
end
