class LocationsController < ApplicationController
  def index
    @locations = current_user.locations
  end

  def create
    location = current_user.locations.build(longitude: params[:longitude], latitude: params[:latitude])
    location.save
    render nothing: true
  end
end
