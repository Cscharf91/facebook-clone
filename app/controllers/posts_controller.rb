class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: [:show]

  def index
    @posts = Post.all.order("created_at DESC")
    @visibilities = [["Friends Only", "Friends Only"], ["Public", "Public"]]
    @post = Post.new
    @comment = Comment.new
  end

  def new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to root_path
  end

  def show
  end

  def new_comment
    new_comment = Comment.new(user: current_user, post_id: params[:post_id], message: params[:message])
    puts new_comment.errors.full_messages if !new_comment.save
    redirect_back(fallback_location: root_path)
  end

  private

  def post_params
    params.require(:post).permit(:message, :visibility)
  end

  def find_post
    unless current_user.posts.find_by(id: params[:id])
      redirect_to root_path
    end
  end

end
