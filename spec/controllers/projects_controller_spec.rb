require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  let(:user) { create :user }
  describe 'loged user' do
    before do
      sign_in user
    end

    describe '#index' do
      let(:subject) { get :index }

      it { is_expected.to have_http_status(:ok) }
      it { is_expected.to render_template(:index) }
    end
  end

  describe 'guest user' do
    describe '#index' do
      let(:subject) { get :index }

      it { is_expected.to have_http_status(:unautorized) }
      it { is_expected.to_not render_template(:index) }
    end
  end
end
