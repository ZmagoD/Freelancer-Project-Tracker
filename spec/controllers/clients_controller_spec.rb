require 'rails_helper'

RSpec.describe ClientsController, type: :controller do
  let(:user) { create :user }

  describe 'signed user' do
    before do
      user.confirm
      sign_in user
      @client = create :client, user: user
    end

    describe "GET #index" do
      it "returns http success" do
        get :index, params: { user_id: user.id }
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #new" do
      it "returns http success" do
        get :new, params: { user_id: user.id }
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #edit" do
      it "returns http success" do
        get :edit, params: { user_id: user.id, id: @client.id }
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #show" do
      it "returns http success" do
        get :show, params: { user_id: user.id, id: @client.id }
        expect(response).to have_http_status(:success)
      end
    end
  end

end
