class UsersController < ApplicationController
  before_action :set_user, except: :index

  def index
    @users = User.all
  end

  def new; end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, alert: "新增成功"
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to root_path, alert: "更新成功"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
  end

  private
  
  def set_user
    @user = User.find_by(id: params[:id]) || User.new
  end
end
