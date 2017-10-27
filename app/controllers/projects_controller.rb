class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def index
    @projects = current_user.projects.paginate(page: params[:page], per_page: 30).preload(:client)
  end

  def show
    @project = current_user.projects.find(params[:id])
    @tasks = @project.tasks.paginate(page: params[:page], per_page: 15)
    @expenses = @project.expenses.paginate(page: params[:page], per_page: 15)
  end

  def destroy
  end

  private

  def project_params
    params.require(:project).permit(:name, :description, :due_date, :client, :estimated_amount, :status)
  end
end
