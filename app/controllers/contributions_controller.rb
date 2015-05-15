class ContributionsController < ApplicationController

  def create

    story = Story.find(params[:story_id])
    contribution = Contribution.new(contribution_params)

    if contribution.save
      story.contributions << contribution
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