class ExpensesController < ApplicationController
  before_action :authenticate_user!
  before_action :filter_project
  before_action :set_expense, only: %i[destroy edit update]

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
      flash[:error] = "Something went wrong: #{display_errors(@expense)}"
      render :new
    end
  end

  def edit
  end

  def update
    if @expense.update_attributes(expense_params)
      flash[:success] = 'Expense successfully updated'
      redirect_to project_path(@project)
    else
      flash[:error] = "Something went wrong: #{display_errors(@expense)}"
      render :edit
    end
  end

  def destroy
    @expense.destroy
    flash[:success] = 'Expense successfully removed'
    redirect_to project_path(@project)
  end

  private

  def expense_params
    params.require(:expense).permit(:amount)
  end

  def set_expense
    @expense = Expense.find_by_id(params[:id])
    raise ActionController::RoutingError.new('Not Found') unless @project == @expense.project
  end

  def filter_project
    @project = Project.find_by_id(params[:project_id])
    raise ActionController::RoutingError.new('Not Found') unless @project.in?(current_user.projects)
  end
end
