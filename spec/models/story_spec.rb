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

	it "Stories can be searched by nearby" do

		expect(Location.within(10, origin: @welly_story.location)).to include(@welly_story.location)
		expect(Location.within(200, origin: @welly_story.location)).to include(@nelly_story.location)
		expect(Location.within(10, origin: @welly_story.location)).not_to include(@akl_story.location)
  	end

  	after(:each) do
  		Story.destroy_all
  		Location.destroy_all
  	end

    describe "#add_contribution" do
      before(:each) do
        @story = FactoryGirl.create(:story)
        @story.add_contribution(FactoryGirl.create(:contribution))
      end

      it "adds a contribution to its list of contributions" do
        expect(@story.contributions.length).to eq(1)
      end

      after(:each) do
        Contribution.destroy_all
        Story.destroy_all
      end

    end

    describe "#completed?" do
      before do
        @story = FactoryGirl.create(:story)
        @story.add_contribution(FactoryGirl.create(:contribution))
      end

      it "returns false if contributions limit has not been met" do
        expect(@story.completed?).to eq(false)
      end

      it "returns true if contributions limit has been met" do
        9.times {@story.add_contribution(FactoryGirl.create(:contribution))}
        expect(@story.completed?).to eq(true)
      end

      after(:each) do
        Contribution.destroy_all
        Story.destroy_all
      end

    end

    describe "#complete!" do

      before do
        @story = FactoryGirl.create(:story)
        10.times { @story.add_contribution(FactoryGirl.create(:contribution)) }
        @story.complete!
      end

      it "makes story completed state return true" do
        expect(@story.completed).to eq(true)
      end

      after do
        Contribution.destroy_all
        Story.destroy_all
      end

    end

end
