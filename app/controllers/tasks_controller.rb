class TasksController < ApplicationController
  before_action :authenticate_user
  before_action :task_params, only: %i(create update)
  before_action :set_task, except: :index

  def index
    @q = current_user.tasks.includes(:tags).ransack(params[:q])
    @tasks = @q.result.page(params[:page])
  end

  def new; end

  def create
    @task = @current_user.tasks.new(task_params)
    if @task.save
      redirect_to root_path, alert: "#{t("new")}#{t("success")}"
    else
      render :new
    end
  end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to root_path, alert: "#{t("update")}#{t("success")}"
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    @task.destroy
    redirect_to root_path, alert: "#{t("destroy")}#{t("success")}"
  end

  private

  def task_params
    params.require(:task).permit(
      :name,
      :start_at,
      :end_at,
      :content,
      :priority,
      :status,
      :tag_list
    )
  end

  def set_task
    @task = @current_user.tasks.find_by(id: params[:id]) || @current_user.tasks.new
  end

  def authenticate_user
    redirect_to login_path, alert: "#{t("login")}" if !user_signed_in?
  end

  def tag_list
    tags.map(&:name).join(', ')
  end
end
