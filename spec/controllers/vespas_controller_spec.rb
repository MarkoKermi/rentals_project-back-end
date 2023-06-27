require 'rails_helper'
require 'factory_bot_rails'


RSpec.describe Api::V1::VespasController, type: :controller do
  describe 'GET #index' do
    it 'returns a successful response with all vespas' do
      vespa1 = create(:vespa)
      vespa2 = create(:vespa)
      get :index
      expect(response).to have_http_status(:ok)
      expect(response_body).to eq(VespasRepresenter.new([vespa1, vespa2]).as_json)
    end
  end

  describe 'POST #create' do
    context 'when authenticated' do
      let(:user) { create(:user) }
      let(:valid_params) { { name: 'Vespa 1', description: 'Description 1', photo: 'photo.jpg', price: 1000, model: 'Model 1', user_id: user.id } }

      before do
        allow(controller).to receive(:authenticate_request!).and_return(true)
        allow(controller).to receive(:current_user!).and_return(user)
      end

      it 'creates a new vespa' do
        expect {
          post :create, params: valid_params
        }.to change(Vespa, :count).by(1)
      end

      it 'returns a successful response with vespa details' do
        post :create, params: valid_params
        expect(response).to have_http_status(:created)
        expect(response_body).to eq(VespaRepresenter.new(Vespa.last).as_json)
      end
    end

    context 'when not authenticated' do
      it 'returns an unauthorized response' do
        post :create
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'GET #show' do
    let(:vespa) { create(:vespa) }

    it 'returns a successful response with vespa details' do
      get :show, params: { id: vespa.id }
      expect(response).to have_http_status(:ok)
      expect(response_body).to eq(VespaRepresenter.new(vespa).as_json)
    end
  end

  describe 'PUT #update' do
    let(:vespa) { create(:vespa) }
    let(:updated_params) { { name: 'Updated Vespa', description: 'Updated Description' } }

    before do
      allow(controller).to receive(:authenticate_request!).and_return(true)
      allow(controller).to receive(:set_vespa).and_return(vespa)
    end

    it 'updates the vespa' do
      put :update, params: { id: vespa.id, vespa: updated_params }
      vespa.reload
      expect(vespa.name).to eq('Updated Vespa')
      expect(vespa.description).to eq('Updated Description')
    end

    it 'returns a successful response with updated vespa details' do
      put :update, params: { id: vespa.id, vespa: updated_params }
      expect(response).to have_http_status(:created)
      expect(response_body).to eq(VespaRepresenter.new(vespa.reload).as_json)
    end
  end

  describe 'DELETE #destroy' do
    let!(:vespa) { create(:vespa) }

    before do
      allow(controller).to receive(:authenticate_request!).and_return(true)
      allow(controller).to receive(:set_vespa).and_return(vespa)
    end

    it 'destroys the vespa' do
      expect {
        delete :destroy, params: { id: vespa.id }
      }.to change(Vespa, :count).by(-1)
    end

    it 'returns a no content response' do
      delete :destroy, params: { id: vespa.id }
      expect(response).to have_http_status(:no_content)
    end
  end

  def response_body
    JSON.parse(response.body)
  end
end
