class StoriesController < ApplicationController

  def index
    render json: Story.all
  end

  # Nice work here. Very clean and minimal logic.
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
    story = Story.find(params[:id])
    # You might consider using `as_json` or a serializer here if you
    # need to customize this JSON output rather than doing this logic
    # in the controller. Right now this controller action needs to know
    # that stories have contributions and how to find the last one.
    # Also, you are creating both of these variables when you only
    # need to set one for each condition (they could be moved inside the
    # conditionals.
    all_contributions = story.contributions
    last_contribution = story.contributions.last
    if story.completed
      render json: {
        title: story.title,
        all_contributions: all_contributions
      }
    else
      # Might be ok to have something like
      # render json: {
      #   title: story.title,
      #   last_contribution: story.contributions.last
      # }
      # but keep an eye on it as this stuff likes to grow. if it got any
      # bigger then really consider moving the logic into a model
      # or serializer object.
      render json: {
        title: story.title,
        last_contribution: last_contribution
      }
    end
  end

  private

  def story_params
    # This line is a bit long. Kinda Rails fault but there could be ways to make
    # it read cleaner. This is a style issue that you would discuss with your team.
    # (Or what ever team you are on in future).
    params.require(:story).permit(:title, :origin_latitude, :origin_longitude, :contribution_limit).merge(completed: false)
  end
end
