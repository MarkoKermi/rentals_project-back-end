# frozen_string_literal: true

module Api
  module V1
    # Namespace for version 1 of the API
    class ApplicationController < ActionController::API
      def authenticate_request!
        return invalid_authentication unless valid_payload?

        find_current_user
        invalid_authentication unless @current_user
      end

      private

      def valid_payload?
        auth_header = request.headers['Authorization']
        token = auth_header.split.last
        AuthenticationTokenService.valid_payload(token)
      end

      def find_current_user
        payload = extract_payload
        @current_user = User.find_by(id: payload['user_id']) if payload
      end

      def extract_payload
        auth_header = request.headers['Authorization']
        token = auth_header.split.last
        AuthenticationTokenService.decode(token)
      rescue StandardError
        nil
      end

      def invalid_authentication
        render json: { error: 'You need to login' }, status: :unauthorized
      end
    end
  end
end
