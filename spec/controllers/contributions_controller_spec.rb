require 'rails_helper'

RSpec.describe ContributionsController, type: :controller do

  describe "#create" do
    before(:each) do
      @story = FactoryGirl.create(:story)
      
      @contribution = FactoryGirl.build(:contribution)

      post :create, :story_id => @story.id, contribution: {content: @contribution.content}
    end

    it "should create a new contribution that belongs to the correct story" do
      expect(@story.contributions.first.content).to include(@contribution.content)
    end

    it "should return an HTTP response of 200 if successful" do
      expect(response.status).to eq(200)
    end

    # There is a gem called database_cleaner that can do this for you
    # for all your tests that you may want to look into.
    after(:each) do
      Contribution.delete_all
      Story.delete_all
    end
  end

end
