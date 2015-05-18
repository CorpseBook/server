require 'rails_helper'

RSpec.describe StoriesController, type: :controller do


  describe "#index" do

    it "should find correct story" do

    end

    it "should return the last 10 updated incomplete stories as json" do
      12.times {create(:story)}
      4.times {create(:completed_story)}
      get :index, :format => :json
      expect(response.body).to eq(Story.where(completed: false).order(updated_at: :desc).limit(10).to_json(
        :methods => [:contributions_length, :last_contribution],
        :only => [:id, :contribution_limit, :title],
        :include => [:location => { :only => [:lat, :lng] }])
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
        :include => [:location => { :only => [:lat, :lng] }]
      ))
    end

    it "Should return proper story format as json if the story is not complete" do
      story = create(:story)
      get :show, id: story.id
      expect(response.body).to eq(story.to_json(
        :methods => [:last_contribution, :contributions_length],
        :only => [:id, :title, :completed, :contribution_limit],
        :include => [:location => { :only => [:lat, :lng] }]
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
      expect(response.body).to include(@nearby_stories.to_json(
        :methods => [:contribution_length],
        :only => [:id, :title, :contribution_limit, :completed],
        :include => [:location => { :only => [:lat, :lng] }]
      ))
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
    end

    it "should return status 200" do
      expect(response.status).to eq(200)
    end

    it "should return true if the story is in range" do
      get :in_range, :story_id => @akl_story.id, search: {lat:-36.840556, lng: 174.74}
      expect(response.body).to include("true")
    end

    it "should return false if the story is not in range" do
      get :in_range, :story_id => @welly_story.id, search: {lat:-36.840556, lng: 174.74}
      expect(response.body).to include("false")
    end

    # it "should return nearby stories as json" do
    #   expect(response.body).to include(@nearby_stories.to_json(
    #     :methods => [:contribution_length],
    #     :only => [:id, :title, :contribution_limit, :completed],
    #     :include => [:location => { :only => [:lat, :lng] }]
    #   ))
    # end
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
        :include => [:location => { :only => [:lat, :lng] }])
      )
    end
  end

end
