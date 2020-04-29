class Admin::UsersController < ApplicationController
  before_action :check_admin_user, only: [:new, :index, :show, :edit, :update, :destroy]

PER = 4

  def index
    @users = User.all.order(created_at:"DESC")
    @users = @users.page(params[:page]).per(PER)
  end

  def show
    @user = User.find(params[:id])
    @tasks = @user.tasks
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice:"ユーザー「#{@user.name}を登録しました」"
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice:"ユーザー「#{@user.name}」を更新しました"
    else
      render :new
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to admin_users_path, notice:"ユーザー「#{@user.name}」を削除しました"
    else
      redirect_to admin_users_path, notice:"ユーザー「#{@user.name}」は削除できません"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end

  def check_admin_user
    unless current_user && current_user.admin?
      redirect_to tasks_path, notice:"あなたは管理者ではありません"
    end
  end

end
