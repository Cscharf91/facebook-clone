class UsersController < ApplicationController
    def index
        @users = User.all
    end

    def profile
        @user = User.find(params[:id])
        @friend_request = FriendRequest.new(receiver_id: @user.id, requestor_id: current_user.id)
    end

    def edit
        @user = current_user
    end

    def update
        @user = current_user
        @user.update(user_params)
        redirect_to profile_user_path(current_user)
    end

    private

    def user_params
        params.require(:user).permit(:age, :location, :occupation, :bio)
    end
end
