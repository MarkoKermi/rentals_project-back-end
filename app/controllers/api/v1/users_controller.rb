module Api
  module V1
    # Creates the Users API
    class UsersController < ApplicationController
      def create
        user = User.new(user_params)

        if user.save
          authenticate_user(user)
          render_authenticated_user(user)
        else
          render_error_response(user.errors)
        end
      end

      private

      def user_params
        params.require(:user).permit(:username, :password)
      end

      def authenticate_user(user)
        token = AuthenticationTokenService.call(user.id) # Generate token
        response.headers['Authorization'] = "Bearer #{token}" # Set token in response header
      end

      def render_authenticated_user(user)
        render json: {
          user: { id: user.id, username: user.username, token: response.headers['Authorization'] },
          message: 'Authentication successful.'
        }, status: :created
      end

      def render_error_response(errors)
        render json: {
          error: errors.full_messages.join(' ')
        }, status: :unprocessable_entity
      end
    end
  end
end
