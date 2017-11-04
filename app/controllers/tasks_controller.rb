class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :filter_project
  before_action :set_task, only: [:show, :edit]

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new do |task|
      task.name = task_params[:name]
      task.description = task_params[:description]
      task.due_date = DateTime.strptime(task_params[:due_date], "%m/%d/%Y")
      task.status = task_params[:status].parameterize.underscore
      task.project = @project
    end
    if @task.save
      flash[:success] = "Successfully added new task to #{@project.name}"
      redirect_to project_path(@project)
    else
      flash[:error] = "Something went wrong: #{@task.errors.full_messages.join(', ').to_s}"
      render :new
    end
  end

  def edit
  end

  private

  def set_task
    @task = Task.find_by_id(params[:id])
    raise ActionController::RoutingError.new('Not Found') unless @task.in? @project.tasks
  end

  def task_params
    params.require(:task).permit(:name, :description, :due_date, :status)
  end

  def filter_project
    @project = Project.find_by_id(params[:project_id])
    raise ActionController::RoutingError.new('Not Found') unless @project.in?(current_user.projects)
  end
end
