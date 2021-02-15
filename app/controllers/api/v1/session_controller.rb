# frozen_string_literal: true

module Api
  module V1
    class SessionController < Devise::SessionsController
      include Response
      before_action :sign_in_params, only: :create
      def create
        if user&.valid_password?(sign_in_params[:password])
          sign_in 'user', user
          json_response('Signed In Successfully', true, { user: user }, :ok)
        else
          json_response('Unauthorized', false, {}, :unauthorized)
        end
      end

      def delete
        result = Session::DeleteService.new(user: valid_token_user)
        result.perform
        if result&.success
          sign_out @user
          json_response('Logged Out Successfully', true, {}, :ok)
        else
          json_response('Something Went Wrong', false, { user: @user }, :bad_request)
        end
      end

      private

      def sign_in_params
        params.require(:sign_in).permit(:email, :password)
      end

      def user
        @user = User.find_for_database_authentication(email: sign_in_params[:email])
      end

      def valid_token_user
        @user = User.find_by(authentication_token: request.headers['AUTH-TOKEN'])
      end
    end
  end
end
