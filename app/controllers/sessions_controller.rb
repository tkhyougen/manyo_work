class SessionsController < ApplicationController
  before_action :check_user, only: [:new]

  def new
    
  end

  def create
    user = User.find_by(email:params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to user_path(user.id), notice:"ログインしました"
    else
      flash[:danger] = "ログインに失敗しました"
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = "ログアウトしました"
    redirect_to new_session_path
  end

  private

  def check_user
    if logged_in?
      redirect_to tasks_path, notice:"ログイン中です。まずログアウトしてください"
    end
  end

end
