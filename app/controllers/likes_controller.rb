class LikesController < ApplicationController
  
  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.new(user_id: current_user.id)
    @like.save
    redirect_to posts_path
  end

  def destroy
    like = Like.find(params[:id])
    like.destroy

    redirect_to posts_path
  end

end
