class HomeController < ApplicationController

  def index
    render json: {
      content: "Home Page"
    }
  end

end
