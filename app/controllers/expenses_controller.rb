class ExpensesController < ApplicationController
  before_action :authenticate_user!
  before_action :filter_project

  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.new(expense_params)
    @expense.project = @project
    if @expense.save
      flash[:success] = "Successfully added new expense to #{@project.name}"
      redirect_to project_path(@project)
    else
      flash[:error] = "Something went wrong: #{@expense.errors.full_messages.join(', ').to_s}"
      render :new
    end
  end

  def edit
    @expense = Expense.find_by_id(params[:id])
  end

  private

  def expense_params
    params.require(:expense).permit(:amount)
  end

  def filter_project
    @project = Project.find_by_id(params[:project_id])
    raise ActionController::RoutingError.new('Not Found') unless @project.in?(current_user.projects)
  end
end
