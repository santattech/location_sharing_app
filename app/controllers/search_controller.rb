class SearchController < ApplicationController

  def index
    if params[:query].present?
      @current_user_friend_ids = current_user.friend_ids
      @users = User.where("name like '%#{params[:query]}%' OR email like '%#{params[:query]}%'").where.not(id: current_user.id).includes(:friends)
    else
      @users = []
    end
  end

end
