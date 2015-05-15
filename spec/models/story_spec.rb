require 'rails_helper'

RSpec.describe Story, type: :model do

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

  	after(:each) do
  		Story.delete_all
  		Location.delete_all
  	end 


end
