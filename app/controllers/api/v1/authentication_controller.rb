module Api
  module V1
    # Handles authentication for the API
    class AuthenticationController < ApplicationController
      class AuthenticateError < StandardError; end

      rescue_from ActionController::ParameterMissing, with: :parameter_missing
      rescue_from AuthenticateError, with: :handle_unauthenticated

      before_action :validate_token, only: [:index]

      def create
        user = find_user_by_username
        authenticate_user(user)
        render_authenticated_user(user)
      end

      private

      def find_user_by_username
        User.find_by(username: params.require(:username))
      end

      def authenticate_user(user)
        raise AuthenticateError unless user&.authenticate(params.require(:password))

        token = AuthenticationTokenService.call(user.id) # Generate token
        response.headers['Authorization'] = "Bearer #{token}" # Set token in response header
      end

      def render_authenticated_user(user)
        render json: {
          user: { id: user.id, username: user.username },
          message: 'Authentication successful.'
        }, status: :created
      end

      def parameter_missing(error)
        render json: { error: error.message }, status: :unprocessable_entity
      end

      def handle_unauthenticated(error)
        render json: { error: error.message }, status: :unauthorized
      end
    end
  end
end
