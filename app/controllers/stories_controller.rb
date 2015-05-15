class StoriesController < ApplicationController

  def index
    render json: Story.all
  end

  def nearby
    coordinates = params[:coordinates]
    range = params[:range]
    nearby = Location.within(range, :origin => coordinates)
    # should return a collection of stories, currently returns a collection of locations
    # each location has lat and lng properties
    stories = Story.locations.within(range, :origin => coordinates)
  end

  def create
    new_story = Story.new(title: story_params[:title], contribution_limit: story_params[:contribution_limit])
    new_location = Location.new(lat: story_params[:lat], lng: story_params[:lng])
    if new_story.save
      new_story.location = new_location
      render status: 200, json: {
        story: new_story,
      }
    else
      render status: 400, json: {
        message: "Your request was not successful."
      }
    end
  end

  def show
    story = Story.find(params[:id])
    all_contributions = story.contributions
    last_contribution = story.contributions.last
    if story.completed
      render json: {
        title: story.title,
        all_contributions: all_contributions
      }
    else
      render json: {
        title: story.title,
        last_contribution: last_contribution
      }
    end
  end

  private

  def story_params
    params.require(:story).permit(:title, :contribution_limit, :lat, :lng)
  end
end
