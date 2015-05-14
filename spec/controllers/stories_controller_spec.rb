require 'rails_helper'

RSpec.describe StoriesController, type: :controller do

  before(:all) do
    Story.destroy_all
  end

  describe '#create' do
    it "should route to post" do
      should route(:post, '/stories').to(action: :create)
    end

    it "should create new story" do
      post :create, {story: {title: "Supernatural Winnipeg", origin_latitude: -41.2967128, origin_longitude: 174.77388449999998, contribution_limit: 12}}
      expect(Story.last.title).to eq("Supernatural Winnipeg")
    end

  end
end
