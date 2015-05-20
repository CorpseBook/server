class ContributionsController < ApplicationController

  def create

    story = Story.find(params[:story_id])
    # If you used associations here you would not have to
    # take this extra step below:
    # `contribution = story.contributions.build(contribution_params)`
    # So it is associated with the story as soon as it saves
    # and it also updates the association in memory.
    contribution = Contribution.new(contribution_params)

    if contribution.save
      story.contributions << contribution
      # Style issue: Watch trailing whitespace
      render status: 200, json: {        
        contribution: contribution
      }
    else
      render status: 400, json: {
        message: "Your request was not successful."
      }
    end
  end

  private

  def contribution_params
    params.require(:contribution).permit(:content)
  end

end
