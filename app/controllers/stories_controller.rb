class StoriesController < ApplicationController

  def index
    stories = Story.where(completed: false).order(updated_at: :desc).limit(10)
    render json: stories, status: 200
  end

  def completed
    stories = Story.where(completed: true)
    render json: stories, status: 200
  end

  def nearby
    lat = params[:search][:lat]
    lng = params[:search][:lng]
    coordinates = [lat, lng]
    range = params[:search].fetch(:range, 5)
    # nearby = Location.within(range, :origin => coordinates)
    # nearby = Location.find(:origin => coordinates, :within => 10)
    nearby_stories = Story.joins(:location).within(range, :origin => coordinates)
    # render status: 200, json: { nearby_stories: nearby_stories }
    render status: 200, json: nearby_stories.map { |story| {
      id: story.id,
      contribution_limit: story.contribution_limit,
      contribution_length: story.contributions.length,
      title: story.title.to_json,
      lat: story.location.lat.to_json,
      lng: story.location.lng.to_json
      }
    }
  end

  def in_range
    story = Story.find(params[:story_id])
    lat = params[:search][:lat]
    lng = params[:search][:lng]
    coordinates = [lat, lng]
    range = params[:search].fetch(:range, 0.5)
    nearby_stories = Story.joins(:location).within(range, :origin => coordinates)
    render status: 200, json: {
      in_range: nearby_stories.include?(story)
    }
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
        id: story.id,
        title: story.title,
        lat: story.location.lat,
        lng: story.location.lng,
        contribution_limit: story.contribution_limit,
        contributions_length: story.contributions.length,
        all_contributions: all_contributions
      }
    else
      render json: {
        id: story.id,
        title: story.title,
        lat: story.location.lat,
        lng: story.location.lng,
        contribution_limit: story.contribution_limit,
        contributions_length: story.contributions.length,
        last_contribution: last_contribution
      }
    end
  end

  private

  def story_params
    params.require(:story).permit(:title, :contribution_limit, :lat, :lng)
  end
end
