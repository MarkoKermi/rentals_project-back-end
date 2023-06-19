module Api
  module V1
    # Creates the Users API
    class UsersController < ApplicationController
      def create
        user = User.new(user_params)

        if user.save
          render_created_response(user)
        else
          render_error_response(user.errors)
        end
      end

      private

      def user_params
        params.require(:user).permit(:username, :password)
      end

      def render_created_response(user)
        render json: {
          user: {
            id: user.id,
            username: user.username
          },
          message: 'User created successfully.'
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
