require 'rails_helper'

RSpec.describe StoriesController, type: :controller do


  describe "#index" do
    it "should return all the stories as json" do
      get :index, :format => :json
      expect(response.body).to eq(Story.all.to_json)
    end
  end

  describe "#create" do
    it "should route to post" do
      should route(:post, '/stories').to(action: :create)
    end

    before do
      post :create, {story: {title: "Supernatural Winnipeg", contribution_limit: 12}}
    end

    it "should create new story" do
      expect(Story.last.title).to eq("Supernatural Winnipeg")
    end

    it "should return an HTTP response of 200 if successful" do
      expect(response.status).to eq(200)
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

  after(:all) do
    Story.destroy_all
  end
end
