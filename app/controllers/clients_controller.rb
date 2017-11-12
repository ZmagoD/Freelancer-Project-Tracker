class ClientsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_client, only: %i[edit show destroy update]

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
      flash[:error] = "Something went wrong: #{display_errors(@client)}"
      render :new
    end
  end

  def edit
  end

  def show
    @earnings = Project.group_by_month(:created_at).where(client: @client).sum(:earned)
    @expenses = Expense.group_by_month(:created_at).where('project_id IN (?)', @client.projects.pluck(:id)).sum(:amount)
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
      flash[:error] = "Something went wrong: #{display_errors(@client)}"
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
