class Story < ActiveRecord::Base
  has_many :contributions
  has_one :location, :as => :locatable  
end
