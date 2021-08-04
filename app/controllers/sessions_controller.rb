class SessionsController < ApplicationController

  def new; end

  def create
    @user = User.find_by(email: params[:user][:email])
    if @user && @user.authenticate(params[:user][:password]) 
        session[:user_id] = @user.id
        flash[:alert] = "登入成功"
        redirect_to root_path
    else
        flash[:alert] = "帳號密碼錯誤"
        render :new
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:alert] = "登出成功"
    redirect_to login_path
  end
end