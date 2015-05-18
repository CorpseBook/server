require 'rails_helper'

RSpec.describe StoriesController, type: :controller do


  describe "#index" do

    it "should return the last 10 updated incomplete stories as json" do
      12.times {create(:story)}
      4.times {create(:completed_story)}
      get :index, :format => :json
      # This test needs a rewrite as uses code from the method itself
      expect(response.body).to eq(Story.where(completed: false).order(updated_at: :desc).limit(10).to_json(:type => 'completed'))
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

    it "should return an HTTP response of 400 if an error occurs" do

    end

  end


  describe "#show" do
    before do
      @story = create(:story)
      @contribution = create(:contribution)
      @story.contributions << @contribution
      get :show, id: @story.id
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
      @akl = create(:auckland)
      @welly = create(:wellington)
      @nelly = create(:nelson)
      @akl_story = Story.create(location: @akl)
      @welly_story = Story.create(location: @welly)
      @nelly_story = Story.create(location: @nelly)
      get :nearby, search: {lat:-36.840556, lng: 174.74}
    end

    it "should return status 200" do
      expect(response.status).to eq(200)
    end

    it "should return the akl story which is within range" do
      expect(response.body).to include(@akl_story.to_json)
    end

    it "should reurn all nearby stories as json" do
      # expect(response.body).to
    end
  end

  describe "#in_range" do
    before(:each) do
      @akl = create(:auckland)
      @welly = create(:wellington)
      @nelly = create(:nelson)
      @akl_story = Story.create(location: @akl)
      @welly_story = Story.create(location: @welly)
      @nelly_story = Story.create(location: @nelly)
      get :in_range, :story_id => @welly_story.id, search: {lat:-36.840556, lng: 174.74}
    end

    it "should return status 200" do
      expect(response.status).to eq(200)
    end

    it "should return true if the story is in range" do
      expect(response.body).to include("true")
    end
  end

  describe "#completed" do
    before(:each) do
      Story.create(title: "something", contribution_limit: 10)
      get :completed
    end
    it "should return complete stories as json" do
      expect(response.body).to eq(Story.where(completed: true).to_json)
    end
  end

end
