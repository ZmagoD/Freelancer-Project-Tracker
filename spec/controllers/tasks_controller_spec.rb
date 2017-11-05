require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:user) { create :user }
  let(:user_two) { create :user, email: "fake_user@asdf.com" }

  describe 'loged user' do
    before do
      sign_in user
      client = create :client, user: user
      non_user_client = create :client, user: user_two
      @non_user_project = create :project, user: user_two, client: non_user_client
      @project = create :project, user: user, client: client
      @task = create :task, project: @project
    end

    describe 'GET #new' do
      let(:subject) { get :new, params: { project_id: @project.id } }
      it { is_expected.to have_http_status(:ok) }
      it { is_expected.to render_template(:new) }
    end

    describe 'GET #edit' do
      let(:subject) { get :edit, params: { project_id: @project.id, id: @task.id } }
      it { is_expected.to have_http_status(:ok) }
      it { is_expected.to render_template(:edit) }
    end

    describe 'GET #show' do
      let(:subject) { get :show, params: { project_id: @project.id, id: @task.id  } }
      it { is_expected.to have_http_status(:ok) }
      it { is_expected.to render_template(:show) }
    end

    describe "POST #create" do
      let(:subject) do
        post :create,
             params: {
               task: { name: 'Test task', description: 'Lorem...',due_date: '10/4/2018', status: 'In progress' },
               project_id: @project.id
             }
      end

      it { is_expected.to have_http_status(:found) }
      it { is_expected.to redirect_to(project_path(@project))}
    end

    describe '#show task that does not belong to user' do
      it 'GET raise an routing error' do
        expect {
          get :show, params: { project_id: @non_user_project.id, id: @task.id }
        }.to raise_error(ActionController::RoutingError)
      end
    end
  end
end
