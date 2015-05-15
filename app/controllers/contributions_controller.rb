class ContributionsController < ApplicationController

  def create
    contribution = Contribution.new(contribution_params)
    if contribution.save
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
    params.require(:contribution).permit(:content).merge(:story_id)
  end

end