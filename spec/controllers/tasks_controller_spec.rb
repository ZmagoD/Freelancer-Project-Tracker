require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:user) { create :user }

  describe 'loged user' do
    before do
      sign_in user
      client = create :client, user: user
      @project = create :project, user: user, client: client
    end

    describe '#new' do
      let(:subject) { get :new, params: { project_id: @project.id } }
      it { is_expected.to have_http_status(:ok) }
      it { is_expected.to render_template(:new) }
    end
  end
end
