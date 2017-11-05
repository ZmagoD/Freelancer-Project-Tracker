require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  let(:user) { create :user }
  let(:client) { create :client, user: user }

  describe 'signed user' do
    before do
      sign_in user
    end

    describe 'GET #index' do
      let(:subject) { get :index }

      it { is_expected.to have_http_status(:ok) }
      it { is_expected.to render_template(:index) }
    end

    describe 'GET #new' do
      let(:subject) { get :new }

      it { is_expected.to have_http_status(:ok) }
      it { is_expected.to render_template(:new) }
    end

    describe 'POST #create' do
      let(:subject) do
        post :create,
             params: {
               project: {
                name: 'test project',
                description: 'lorem...',
                due_date: 10.days.from_now,
                status: 'On hold',
                client: client.id
               }
             }
      end

      it { is_expected.to have_http_status(:found) }
      it { is_expected.to redirect_to(project_path(Project.find_by_name('test project'))) }
    end
  end

  describe 'guest user' do
    describe 'GET #index' do
      let(:subject) { get :index }

      it { is_expected.to have_http_status(302) }
      it { is_expected.to redirect_to(new_user_session_path) }
    end
  end
end
