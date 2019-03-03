class UsersController < ApplicationController
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
      flash.now[:danger]='ユーザの登録にしました。'
      render :new
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :sex, :age, :email, :password, :password_confirmation)
  end
end
