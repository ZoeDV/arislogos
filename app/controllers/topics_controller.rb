class TopicsController < ApplicationController
  before_action :require_user_logged_in
  
  def show
    @topic = Topic.find(params[:id])
    @posts = @topic.posts.order('created_at DESC').page(params[:page])
    @rank = params[:rank]
    
    @interest_sum = Topic.total_interest
    
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = current_user.topics.build(topics_params)
    if @topic.save
      flash[:success] = 'お題を投稿しました。'
      redirect_to root_url
    else
      @topics = Topic.all.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'お題の投稿に失敗しました。'
      render :new
    end
  end
  
  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
    flash[:success] = 'お題を削除しました。'
    
    redirect_to root_url
  end
  
  private
  
  def topics_params
    params.require(:topic).permit(:content)
  end
end
