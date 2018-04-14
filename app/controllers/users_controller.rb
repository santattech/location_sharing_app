class UsersController < ApplicationController
  def show
    @friends = current_user.friends.where.not(user_friends: {accepted_at: nil})
  end

  def add_friend
    @user = User.find(params[:id])
    current_user.friends << @user
    @current_user_friend_ids = current_user.friend_ids
  end

  def show_friend_requests
    @senders = current_user.friend_requests_sender
    render layout: false
  end

  def accept_friend
    user = current_user.friend_requests_sender.find(params[:id])
    user_friend = current_user.user_friends.build(friend_id: user.id, accepted_at: Time.now)

    user.user_friends.where(user_friends: { friend_id: current_user.id }).update_all(accepted_at: Time.now) if user_friend.save
    render layout: false
  end

  def share_locations
    @location = current_user.locations.find(params[:location_id])
    @share_locations = current_user.shared_locations.where(location_id: @location.id)
    @share_with_ids = @share_locations.pluck(:share_with_id)
    @friends = current_user.friends.where.not(user_friends: {accepted_at: nil})
    render layout: false
  end

  def friends_locations
    @locations = current_user.locations_shared_with_me.includes(:user)
  end
end
