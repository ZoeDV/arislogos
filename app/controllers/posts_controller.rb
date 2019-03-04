class PostsController < ApplicationController
  before_action :require_user_logged_in
  
  def new
    @post = Post.new
    @topic = Topic.find(params[:topic_id])
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = current_user.posts.build(posts_params)
    @post[:topic_id]=@topic.id
    
    if @post.save
      flash[:success] = '説明を投稿しました。'
      redirect_to topic_path(@topic)
    else
      flash.now[:danger] = '説明の投稿に失敗しました。'
      render :new
    end
  end
  
  private
  
  def posts_params
    params.require(:post).permit(:content, :image)
  end
end
