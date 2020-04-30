class UsersController < ApplicationController
  before_action :check_user_login, only: [:new]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user.id), notice:"ログインしました"
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to tasks_path, notice: '他の人のページへアクセスは出来ません'
    end
  end

  def update
  end

  def destroy
  end


  private

  def user_params
    params.require(:user).permit(:name, :email,:password, :password_confirmation)
  end

  def check_user_login
    if logged_in?
      redirect_to tasks_path, notice:"ログイン中です。まずログアウトしてください"
    end
  end


end
