class Location < ActiveRecord::Base
  include Geokit::Geocoders

  belongs_to :locatable, :polymorphic => true
  acts_as_mappable :default_units => :kms, :lat_column_name => :lat, :lng_column_name => :lng

  before_save :reverse_geocode

  def reverse_geocode
    response = Geokit::Geocoders::GoogleGeocoder.reverse_geocode([self.lat, self.lng])
    self.address = response.full_address
  end

end


