class SharedLocationsController < ApplicationController
  def create
    @shared_location = current_user.shared_locations.build(share_with_id: params[:user_id], location_id: params[:location_id])
    @shared_location.save
    render layout: false
  end

    def destroy
      @shared_location = current_user.shared_locations.find(params[:id])
      @shared_location.destroy
      render layout: false
    end
end
