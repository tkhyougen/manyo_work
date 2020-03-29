class SessionsController < ApplicationController
  def create
    if user = User.find_by(email: params[:session][:email].downcase)

    else
      flash.now[:danger] = "ログインに失敗しました"
      render :new
    end
  end
end
