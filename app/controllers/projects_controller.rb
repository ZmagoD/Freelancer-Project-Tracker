class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :filter_client, only: %i[create update]
  before_action :setProject, only: %i[edit destroy show update]

  def index
    @projects = current_user.projects.paginate(page: params[:page], per_page: 30).preload(:client)
  end

  def new
    @project = Project.new
    @client = Client.new
  end

  def create
    @project = Project.new do |project|
      project.name = project_params[:name]
      project.description = project_params[:description]
      project.due_date = DateTime.strptime(project_params[:due_date], '%m/%d/%Y %I:%M %p')
      project.estimated_amount = project_params[:estimated_amount]
      project.status = project_params[:status].parameterize.underscore
      project.client = Client.find_by_id(project_params[:client])
      project.user = current_user
    end
    if @project.save
      flash[:success] = "Successfully added new project: #{@project.name}"
      redirect_to project_path(@project)
    else
      flash[:error] = "Something went wrong: #{display_errors(@project)}"
      render :new
    end
  end

  def show
    @tasks = @project.tasks.paginate(page: params[:page], per_page: 15)
    @expenses = @project.expenses.paginate(page: params[:page], per_page: 15)
  end

  def edit
  end

  def update
    @project.update_attributes(name: project_params[:name]) do |project|
      project.description = project_params[:description]
      project.due_date = DateTime.strptime(project_params[:due_date], '%m/%d/%Y %I:%M %p')
      project.estimated_amount = project_params[:estimated_amount]
      project.status = project_params[:status].parameterize.underscore
    end
    if @project.save
      flash[:success] = "Successfully updated project #{@project.name}"
      redirect_to project_path(@project)
    else
      flash[:error] = "Something went wrong: #{display_errors(@project)}"
      render :edit
    end
  end

  def destroy
    @project.destroy
    flash[:success] = 'Project successfully removed'
    redirect_to project_path
  end

  private

  def setProject
    @project = current_user.projects.find(params[:id])
  end

  def filter_client
    return unless project_params[:client]
    raise ActionController::RoutingError.new('Not Found') unless project_params[:client].to_i.in? current_user.clients.pluck(:id)
  end

  def project_params
    params.require(:project).permit(:name, :description, :due_date, :estimated_amount, :status, :client)
  end
end
