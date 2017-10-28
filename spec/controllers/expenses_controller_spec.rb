require 'rails_helper'

RSpec.describe ExpensesController, type: :controller do
  let(:user) { create :user }

  describe 'loged user' do
    before do
      sign_in user
      client = create :client, user: user
      @project = create :project, user: user, client: client
      @expense = create :expense, project: @project
    end

    describe '#new' do
      let(:subject) { get :new, params: { project_id: @project.id } }
      it { is_expected.to have_http_status(:ok) }
      it { is_expected.to render_template(:new) }
    end

    describe '#update' do
      let(:subject) { get :update, params: { project_id: @project.id, id: @expense.id, expense: { amount: 500 } } }
      it { is_expected.to redirect_to(project_path(@project)) }
    end

    describe '#edit' do
      let(:subject) { get :edit, params: { project_id: @project.id, id: @expense.id } }
      it { is_expected.to have_http_status(:ok) }
      it { is_expected.to render_template(:edit) }
    end
  end
end
