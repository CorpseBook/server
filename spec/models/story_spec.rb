require 'rails_helper'

RSpec.describe Story, type: :model do

	before(:each) do
		@EDA = create(:EDA)
    @tepapa = create(:tepapa)
    @karori_park = create(:karori_park)
    @ngaio = create(:ngaio)
    @madagascar = create(:madagascar)

    @EDA_story = Story.create(location: @EDA, title: 'EDA')
    @tepapa_story = Story.create(location: @tepapa, title: 'TePapa')
    @karori_park_story = Story.create(location: @karori_park, title: 'Karori Park')
    @ngaio_story = Story.create(location: @ngaio, title: 'Ngaio')
    @madagascar_story = Story.create(location: @madagascar, title: 'Madagascar')
	end

	it "Stories can be created and sorted by location" do
		expect(Location.farthest(origin: @EDA_story.location).first).to eq(@madagascar_story.location)
  end

	it "Stories can be searched by nearby" do
		expect(Location.within(2, origin: @EDA_story.location)).to include(@EDA_story.location, @tepapa_story.location)
		expect(Location.within(5, origin: @EDA_story.location)).to include(@karori_park_story.location)
		expect(Location.within(10000, origin: @EDA_story.location)).not_to include(@madagascar_story.location)
  end

    describe "#add_contribution" do
      before(:each) do
        @story = create(:story)
        @story.add_contribution(create(:contribution))
      end

      it "adds a contribution to its list of contributions" do
        expect(@story.contributions.length).to eq(1)
      end

    end

    describe "#completed?" do
      before do
        @story = create(:story)
        @story.add_contribution(create(:contribution))
      end

      it "returns false if contributions limit has not been met" do
        expect(@story.completed?).to eq(false)
      end

      it "returns true if contributions limit has been met" do
        9.times {@story.add_contribution(create(:contribution))}
        expect(@story.completed?).to eq(true)
      end


    end

    describe "#complete!" do

      before do
        @story = create(:story)
        10.times { @story.add_contribution(create(:contribution)) }
        @story.complete!
      end

      it "makes story completed state return true" do
        expect(@story.completed).to eq(true)
      end

    end

end
