require 'rails_helper'

RSpec.describe 'Authentications', type: :request do
  describe 'POST /login' do
    let(:user) { FactoryBot.create(:user, username: 'test', password: 'password') }

    it 'returns error when username does not exist' do
      post '/api/v1/login', params: { username: 'test1', password: 'password' }
    end
  end
end
