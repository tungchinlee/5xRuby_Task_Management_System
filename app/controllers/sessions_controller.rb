class SessionsController < ApplicationController

  def new; end

  def create
    @user = User.find_by(email: params[:user][:email])
    if @user && @user.authenticate(params[:user][:password]) 
        session[:user_id] = @user.id
        flash[:success] = "登入成功"
        redirect_to root_path
    else
        flash[:alert] = "帳號密碼錯誤"
        render :new
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:success] = "刪除成功"
    redirect_to login_path
  end
end