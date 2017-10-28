class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :filter_project

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :due_date, :status)
  end

  def filter_project
    @project = Project.find_by_id(params[:project_id])
    raise ActionController::RoutingError.new('Not Found') unless @project.in?(current_user.projects)
  end
end
