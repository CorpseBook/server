require 'rails_helper'

RSpec.describe ContributionsController, type: :controller do


  describe "#create" do
    before do
      post :create, {content: "All kinds of ghosty stuff."}, story_id: 1
      # @story = Story.create(title: "Supernatural Winnipeg", origin_latitude: -41.2967128, origin_longitude: 174.77388449999998, contribution_limit: 12)
      # @contribution = Contribution.create(content: "Here is my contribution.")
      # post :create, story_id: 1
    end

    it "should create new contribution" do
      expect(Contribution.last).to include("Here is my contribution.")
    end

    it "should return an HTTP response of 200 if successful" do
      expect(response.status).to eq(200)
    end
  end

end