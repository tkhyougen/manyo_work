class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user = User.find_by(email: params[:session][:email].downcase)

    else
      flash.now[:danger] = "ログインに失敗しました"
      render :new
    end
  end
end
