require 'rails_helper'

RSpec.describe StoriesController, type: :controller do


  describe "#index" do
    it "should return the last 10 updated incomplete stories as json" do
      get :index, :format => :json
      # This test needs a rewrite as uses code from the method itself
      expect(response.body).to eq(Story.where(completed: false).order(updated_at: :desc).limit(10).to_json)
    end
  end

  describe "#create" do
    it "should route to post" do
      should route(:post, '/stories').to(action: :create)
    end

    before do
      post :create, {story: {title: "Supernatural Winnipeg", contribution_limit: 12, lat:-41.270833, lng: 173.283889}}
    end

    it "should create new story" do
      expect(Story.last.title).to eq("Supernatural Winnipeg")
    end

    it "should return an HTTP response of 200 if successful" do
      expect(response.status).to eq(200)
    end

    it "should contains location object" do
      expect(Story.last.location.lat).to eq(-41.270833)
    end
  end


  describe "#show" do
    before do
      @story = FactoryGirl.create(:story)
      @contribution = FactoryGirl.create(:contribution)
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
      @akl = FactoryGirl.create(:auckland)
      @welly = FactoryGirl.create(:wellington)
      @nelly = FactoryGirl.create(:nelson)
      @akl_story = Story.create(location: @akl)
      @welly_story = Story.create(location: @welly)
      @nelly_story = Story.create(location: @nelly)
      # get :"stories/nearby", range: 10, coordinates:

      get :nearby, search: {lat:-36.840556, lng: 174.74}
    end

    it "should return status 200" do
      expect(response.status).to eq(200)
    end

    it "should return the akl story which is within range" do
      expect(response.body).to include(@akl_story.to_json)
    end

  end

  after(:all) do
    Story.destroy_all
  end
end
