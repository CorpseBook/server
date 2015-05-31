require 'rails_helper'

RSpec.describe Location, type: :model do

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

	it "Location models can be created and sorted by location" do
  		expect(Location.farthest(origin: @EDA).first).to eq(@madagascar)
  	end

end
