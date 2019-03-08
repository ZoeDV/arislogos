class InterestsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    
    if params[:type] == "Agree"
      current_user.agree(@post)
      flash[:success] = "説明をいいね！と評価しました。"
    end
    
    if params[:type] == "Disagree"
      current_user.disagree(@post)
      flash[:success] = "説明を違うね！と評価しました。"
    end
    
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @post = Post.find(params[:post_id])
    
    if params[:type] == "Agree"
      current_user.del_agree(@post)
      flash[:success] = "説明のいいね！を削除しました。"
    end
    
    if params[:type] == "Disagree"
      current_user.del_disagree(@post)
      flash[:success] = "説明の違うね！を削除しました。"
    end
    
    redirect_back(fallback_location: root_path)
  end
end
