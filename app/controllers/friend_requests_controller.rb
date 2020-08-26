class FriendRequestsController < ApplicationController

  def create
    @user = User.find(params[:receiver_id])
    @friend_request = FriendRequest.new(requestor_id: params[:requestor_id], receiver_id: params[:receiver_id])
    if @friend_request.save
      redirect_to profile_user_path(@user)
    else
      @friend_request.errors.full_messages
      redirect_to profile_user_path(params[@user])
    end
  end

  def destroy
    @friend_request = FriendRequest.find(params[:id])
    @friend_request.destroy
    redirect_back(fallback_location: root_path)
  end

  def index
    @incoming_fr = current_user.received_requests unless current_user.received_requests.empty?
    @outgoing_fr = current_user.requests unless current_user.requests.empty?
  end

  def show
  end

end
