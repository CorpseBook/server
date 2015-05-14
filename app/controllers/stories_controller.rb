class StoriesController < ApplicationController

  def index

  end

  def create
    story = Story.new(story_params)
    if story.save
      render status: 200, json: {
        story: story,
      }
    else
      render status: 400, json: {
        message: "Your request was not successful."
      }
    end
  end

  private

  def story_params
    params.require(:story).permit(:title, :origin_latitude, :origin_longitude, :contribution_limit).merge(completed: false)
  end
end
