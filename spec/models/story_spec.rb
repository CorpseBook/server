require 'rails_helper'

RSpec.describe Story, type: :model do

  # Lots of setup here. Might be a sign of tight coupling somewhere
  # or that this is not a unit test but an integration test.
	before(:each) do
		akl = FactoryGirl.create(:auckland)
		@welly = FactoryGirl.create(:wellington)
		nelly = FactoryGirl.create(:nelson)
		@akl_story = Story.create(location: akl)
		@welly_story = Story.create(location: @welly)
		@nelly_story = Story.create(location: nelly)
	end

	it "Stories can be created and sorted by location" do
		expect(Location.farthest(origin: @welly_story.location).first).to eq(@akl_story.location)
  	end

	it "Stories can searched by nearby" do

		expect(Location.within(10, origin: @welly_story.location)).to include(@welly_story.location)
		expect(Location.within(200, origin: @welly_story.location)).to include(@nelly_story.location)
		expect(Location.within(10, origin: @welly_story.location)).not_to include(@akl_story.location)
  	end  	

  	after(:each) do
  		Story.destroy_all
  		Location.destroy_all
  	end 


end
