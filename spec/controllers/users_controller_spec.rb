require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe 'POST #create' do
    context 'when valid parameters are provided' do
      let(:valid_params) { { user: { username: 'john_doe', password: 'password' } } }

      it 'creates a new user' do
        expect {
          post :create, params: valid_params
        }.to change(User, :count).by(1)
      end

      it 'returns a successful response with user details' do
        post :create, params: valid_params
        expect(response).to have_http_status(:created)
        expect(response_body['user']).to include('id', 'username')
        expect(response_body['message']).to eq('User created successfully.')
      end
    end

    context 'when invalid parameters are provided' do
      let(:invalid_params) { { user: { username: '', password: 'password' } } }

      it 'does not create a new user' do
        expect {
          post :create, params: invalid_params
        }.not_to change(User, :count)
      end

      it 'returns an error response with error details' do
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response_body['error']).to be_present
      end
    end
  end

  def response_body
    JSON.parse(response.body)
  end
end
