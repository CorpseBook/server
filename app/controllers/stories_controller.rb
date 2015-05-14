class StoriesController < ApplicationController

  def index

  end

  def create
    story = Story.new(story_params)
    if story.save
      render status: 200
    else
      render status: 400
    end
    redirect_to '/'
  end

  private

  def story_params
    params.require(:story).permit(:title, :origin_latitude, :origin_longitude, :contribution_limit).merge(completed: false)
  end
end
