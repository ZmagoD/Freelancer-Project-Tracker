class TasksController < ApplicationController
  before_action :authenticate_user!
  def show
  end

  def new
  end

  def edit
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, due_date, :status)
  end
end
