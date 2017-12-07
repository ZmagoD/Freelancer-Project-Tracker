class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :filter_client, only: %i[create update]
  before_action :setProject, only: %i[edit destroy show update]

  def index
    fitered_projects = current_user.projects.where.not(status: :archived)
    if params[:archived]
      fitered_projects = current_user.projects.where(status: :archived)
      @archive = true
    end
    @projects = fitered_projects.paginate(page: params[:page], per_page: 30).preload(:client)
  end

  def new
    @project = Project.new
    @client = Client.new
  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user
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
    @project.update_attributes(project_params)
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
    redirect_to projects_path
  end

  private

  def setProject
    @project = current_user.projects.find(params[:id])
  end

  def filter_client
    return unless project_params[:client_id]
    raise ActionController::RoutingError.new('Not Found') unless project_params[:client_id].to_i.in? current_user.clients.pluck(:id)
    params[:client_id] = params[:client_id].to_i
  end

  def project_params
    params.require(:project).permit(:name, :description, :set_due_date, :estimated_amount, :set_status, :client_id, :earned)
  end
end
