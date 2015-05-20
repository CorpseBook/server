require 'rails_helper'

RSpec.describe StoriesController, type: :controller do


  describe "#index" do

    it "should find correct story" do

    end

    it "should return the last 20 updated incomplete stories as json" do
      12.times {create(:story)}
      4.times {create(:completed_story)}
      get :index, :format => :json
      expect(response.body).to eq(Story.where(completed: false).order(updated_at: :desc).limit(20).to_json(
        :methods => [:contributions_length, :last_contribution],
        :only => [:id, :contribution_limit, :title, :completed],
        :include => [:location => { :only => [:lat, :lng, :address] }])
      )
    end
  end

  describe "#create" do

    it "should route to post" do
      should route(:post, '/stories').to(action: :create)
    end

    before do
      @title = "Supernatural Winnipeg"
      @lat = -41.270833
      @lng = 173.283889
      @contribution_limit = 12
      post :create, {story: {title: @title, contribution_limit: @contribution_limit, lat:@lat, lng: @lng }}
    end

    it "should create new story" do
      expect(Story.all.length).to eq(1)
    end

    it "should create a new story with a title" do
      expect(Story.all.last.title).to eq(@title)
    end

    it "should create a new story with a contribution limit" do
      expect(Story.all.last.contribution_limit).to eq(@contribution_limit)
    end

    it "should create a new story with a location" do
      expect(Story.last.location.lat).to eq(@lat)
      expect(Story.last.location.lng).to eq(@lng)
    end

    it "should return an HTTP response of 200 if successful" do
      expect(response.status).to eq(200)
    end

  end


  describe "#show" do

    before do
      @story = create(:story)
      @completed_story = create(:completed_story)
      @contribution = create(:contribution)
      @story.contributions << @contribution
      get :show, id: @story.id
    end

    it "Should return proper story format as json if the story is complete" do
      story = create(:completed_story)
      get :show, id: story.id
      expect(response.body).to eq(story.to_json(
        :methods => [:all_contributions, :contributions_length],
        :only => [:id, :title, :completed, :contribution_limit],
        :include => [:location => { :only => [:lat, :lng, :address] }]
      ))
    end

    it "Should return proper story format as json if the story is not complete" do
      story = create(:story)
      get :show, id: story.id
      expect(response.body).to eq(story.to_json(
        :methods => [:last_contribution, :contributions_length],
        :only => [:id, :title, :completed, :contribution_limit],
        :include => [:location => { :only => [:lat, :lng, :address] }]
      ))
    end

    it "should find a particular story's contributions" do
      expect(@story.contributions).to include(@contribution)
    end

    it "should return the story's title in json" do
      expect(response.body).to include(@story.title.to_json)
    end

    it "should return the story's contribution in json" do
      expect(response.body).to include(@contribution.to_json)
    end

  end

  describe "#nearby" do
    before(:each) do
      @EDA = FactoryGirl.create(:EDA)
      @tepapa = FactoryGirl.create(:tepapa)
      @karori_park = FactoryGirl.create(:karori_park)
      @ngaio = FactoryGirl.create(:ngaio)
      @madagascar = FactoryGirl.create(:madagascar)

      @EDA_story = Story.create(location: @EDA, title: 'EDA')
      @tepapa_story = Story.create(location: @tepapa, title: 'TePapa')
      @karori_park_story = Story.create(location: @karori_park, title: 'Karori Park')
      @ngaio_story = Story.create(location: @ngaio, title: 'Ngaio')
      @madagascar_story = Story.create(location: @madagascar, title: 'Madagascar')

      get :nearby, search: {lat:@EDA.lat, lng:@EDA.lng}
    end

    it "should return status 200" do
      expect(response.status).to eq(200)
    end

    it "should return the akl story which is within range" do
      expect(response.body).to include(@EDA.to_json(
        :methods => [:contribution_length],
        :only => [:id, :title, :contribution_limit, :completed],
        :include => [:location => { :only => [:lat, :lng, :address] }]
      ))
    end
    # it "should return the correct stories that are in range" do
    #   expect(response.body).to include('EDA', 'TePapa', 'Karori Park')
    # end

    # it "should not return stories out of range" do
    #   expect(response.body).to_not include('Ngaio', 'Madagascar')
    # end
  end

  describe "#in_range" do

    before(:each) do
      @EDA = FactoryGirl.create(:EDA)
      @tepapa = FactoryGirl.create(:tepapa)
      @karori_park = FactoryGirl.create(:karori_park)
      @ngaio = FactoryGirl.create(:ngaio)
      @madagascar = FactoryGirl.create(:madagascar)

      @EDA_story = Story.create(location: @EDA, title: 'EDA')
      @tepapa_story = Story.create(location: @tepapa, title: 'TePapa')
      @karori_park_story = Story.create(location: @karori_park, title: 'Karori Park')
      @ngaio_story = Story.create(location: @ngaio, title: 'Ngaio')
      @madagascar_story = Story.create(location: @madagascar, title: 'Madagascar')

    end

    it "should return status 200" do
      get :in_range, {story_id: @EDA_story.id, search: {lat:@EDA.lat, lng:@EDA.lng}}
      expect(response.status).to eq(200)
    end

    it "should return true if the story is in range" do
      get :in_range, {story_id: @EDA_story.id, search: {lat:@EDA.lat, lng:@EDA.lng}}
      expect(response.body).to include("true")
    end

    it "should return false if the story is not in range" do
      get :in_range, {story_id: @madagascar_story.id, search: {lat:@EDA.lat, lng:@EDA.lng}}
      expect(response.body).to include("false")
    end

  end

  describe "#completed" do
    before(:each) do
      Story.create(title: "something", contribution_limit: 10)
      get :completed
    end
    it "should return complete stories as json" do
      expect(response.body).to eq(Story.where(completed: true).to_json(
        :methods => [:first_contribution],
        :only => [:id, :title],
        :include => [:location => { :only => [:lat, :lng, :address] }])
      )
    end
  end

end
