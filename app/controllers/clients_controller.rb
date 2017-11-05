class ClientsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_client, only: [:edit, :show, :destroy, :update]

  def index
    @clients = current_user.clients.paginate(page: params[:page], per_page: 30)
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    @client.user = current_user
    if @client.save
      flash[:success] = 'Successfully added new client'
      redirect_to user_clients_path(current_user)
    else
      flash[:error] = "Something went wrong: #{@client.errors.full_messages.join(', ').to_s}"
      render :new
    end
  end

  def edit
  end

  def show
  end

  def destroy
    @client.destroy
    flash[:success] = 'Client successfully removed'
    redirect_to user_clients_path(current_user)
  end

  def update
    @client.update_attributes(client_params)
    if @client.save
      flash[:success] = "Successfully updated client #{@client.full_name}"
      redirect_to user_clients_path(current_user)
    else
      flash[:error] = "Something went wrong: #{@client.errors.full_messages.join(', ').to_s}"
      render :edit
    end
  end

  private

  def set_client
    raise ActionController::RoutingError.new('Not Found') unless params[:id].to_i.in? current_user.clients.pluck(:id)
    @client = Client.find_by_id(params[:id])
  end

  def client_params
    params.require(:client).permit(:full_name, :phone, :email)
  end
end
