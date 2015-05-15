require 'rails_helper'

RSpec.describe Story, type: :model do
  describe "Story is locatable" do
  		before(:each) do
  			akl = FactoryGirl.create(:auckland)
  			@welly = FactoryGirl.create(:wellington)
  			nelly = FactoryGirl.create(:nelson)
  			@akl_story = Story.create(location: akl)
  			@welly_story = Story.create(location: @welly)
  			@nelly_story = Story.create(location: nelly)
  		end

  		it "it can be created and sorted by location" do
  			expect(Location.farthest(origin: @welly_story.location).first).to eq(@akl_story.location)
  			# expect(Story.farthest(origin: @welly_story).first).to eq(@akl_story)
  	  	end

  	  	after(:each) do
  	  		Story.delete_all
  	  		Location.delete_all
  	  	end
  end

end
