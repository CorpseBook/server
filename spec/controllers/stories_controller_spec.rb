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
      post :create, {story: {title: "Supernatural Winnipeg", origin_latitude: -41.2967128, origin_longitude: 174.77388449999998, contribution_limit: 12}}
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
      @story = Story.create(title: "Joe's Adventure", origin_latitude: -42.29, origin_longitude: 175.77, contribution_limit: 100)
    end
    it "should find a particular story" do
      get :show, id: @story.id
      expect(response.body).to eq(@story.to_json)
    end
  end

  after(:all) do
    Story.destroy_all
  end
end
