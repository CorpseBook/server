require 'rails_helper'

RSpec.describe Location, type: :model do

  # Couple of notes:
  # If you don't put :each then :each is the default anyway
  # You can also use `let`s here instead of instance vars.
  # Neither are required but just some tips
	before(:each) do
		@akl = FactoryGirl.create(:auckland)
		@welly = FactoryGirl.create(:wellington)
		@nelly = FactoryGirl.create(:nelson)
	end

	it "Location models can be created and sorted by location" do
  		expect(Location.farthest(origin: @welly).first).to eq(@akl)
  	end

  	after(:each) do
  		Location.delete_all
  	end

end
