class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :filter_project
  before_action :set_task, only: %i[show edit update destroy]

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.project = @project
    if @task.save
      flash[:success] = "Successfully added new task to #{@project.name}"
      redirect_to project_path(@project)
    else
      flash[:error] = "Something went wrong: #{display_errors(@task.errors)}"
      render :new
    end
  end

  def edit
  end

  def update
    @task.update_attributes(task_params)
    if @task.save
      flash[:success] = "Successfully updated task #{@task.reload.name}"
      redirect_to project_path(@project)
    else
      flash[:error] = "Something went wrong: #{display_errors(@client)}"
      render :edit
    end
  end

  def destroy
    @task.destroy
    flash[:success] = 'Task successfully removed'
    redirect_to project_path(@project)
  end

  private

  def set_task
    @task = Task.find_by_id(params[:id])
    raise ActionController::RoutingError.new('Not Found') unless @task.in? @project.tasks
  end

  def task_params
    params.require(:task).permit(:name, :description, :set_due_date, :set_status)
  end

  def filter_project
    @project = Project.find_by_id(params[:project_id])
    raise ActionController::RoutingError.new('Not Found') unless @project.in?(current_user.projects)
  end
end
