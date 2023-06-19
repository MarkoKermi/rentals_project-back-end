# frozen_string_literal: true

# Service class for generating and decoding authentication tokens.
class AuthenticationTokenService
  HMAC_SECRET = Rails.application.credentials.secret_key_base
  ALGORITHM_TYPE = 'HS256'

  def self.call(user_id)
    payload = { user_id: user_id }
    JWT.encode payload, HMAC_SECRET, ALGORITHM_TYPE
  end

  def self.decode(token)
    JWT.decode token, HMAC_SECRET, true, { algorithm: ALGORITHM_TYPE }
  rescue JWT::DecodeError
    false
  end

  def self.valid_payload(_payload)
    true
  end

  def self.expired_token
    render json: { error: 'Invalid or missing token! Please login again' }, status: :unauthorized
  end
end
# Path: app/controllers/api/v1/authentication_controller.rb
