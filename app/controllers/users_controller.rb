class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[edit update destroy]

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      sign_in @user, bypass: true
      flash[:success] = 'Your account was successfully updated!'
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = 'Your account was deleted!'
    redirect_to root_path
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:currency, :full_name)
  end
end
