class StoriesController < ApplicationController

  def index
    render json: Story.all
  end

  def create
    new_story = Story.new(story_params)
    if new_story.save
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
    render json: {{
      lat: 41.2864603,
      lng: 174.77623600000004
    }, {
      lat: 51.5073509,
      lng: 0.12775829999998223
    }, {
      lat: 30,
      lng: 100
    }}
  end

  private

  def story_params
    params.require(:story).permit(:title, :origin_latitude, :origin_longitude, :contribution_limit).merge(completed: false)
  end
end
