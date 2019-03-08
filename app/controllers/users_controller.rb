class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show]
  
  def show
    @user = User.find(params[:id])
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
    #@user.image = params[:image]
    if @user.update(image_params)
      flash[:success] = 'プロフィール画像を登録しました。'
      redirect_to user_path(@user)
    else
      flash.now[:danger]='プロフィール画像の登録にしました。'
      render user_path
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :sex, :age)
  end
  def image_params
    params.require(:user).permit(:image)
  end
end
