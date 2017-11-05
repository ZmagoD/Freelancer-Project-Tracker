class ClientsController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def new
    @client = Client.new
  end

  def create

  end

  def edit
  end

  def show
  end

  private

  def client_params
    params.require(:client).permit(:full_name, :phone, :email)
  end
end
