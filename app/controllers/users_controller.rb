class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show]
  
  def show
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to root_url
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to root_url
    else
      flash.now[:danger]='ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user == current_user 
      @user.image.cache! unless @user.image.blank?
      if @user.update(user_params)
        flash[:success] = 'プロフィール画像を登録しました。'
        redirect_to @user
      else
        flash.now[:danger]='プロフィール画像の登録に失敗しました。'
        render user_path
      end
    else
      redirect_to root_url
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :sex, :age, :image, :image_cache)
  end
end
