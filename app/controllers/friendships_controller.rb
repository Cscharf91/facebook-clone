class FriendshipsController < ApplicationController
    
    def create
        @friend = User.find(params[:friend_id])
        @friend_request = FriendRequest.find_by(requestor_id: @friend.id, receiver_id: current_user.id)
        @friendship = Friendship.new(user_id: current_user.id, friend_id: @friend.id)
        @friendship2 = Friendship.new(user_id: @friend.id, friend_id: current_user.id)
        
        if @friendship.save && @friendship2.save
            @friend_request.destroy
            redirect_to profile_user_path(@friend)
        else
            puts @friendship.errors.full_messages
            redirect_to profile_user_path(params[:friend_id])
        end
    end

    def destroy
        @friendship = Friendship.find(params[:id])
        @user = @friendship.user.id
        @friendship2 = Friendship.find_by(user_id: current_user.id, friend_id: @friendship.user.id)
        puts @friendship.attributes
        puts @friendship2.attributes
        #@friendship2 = Friendship.where(user_id: @user.id, friend_id: current_user.id)
        @friendship.destroy
        @friendship2.destroy
        redirect_to profile_user_path(@user)
    end

    def show
    end
end
