# frozen_string_literal: true

module Api
  class ApiController < ActionController::API
    include ActionController::HttpAuthentication::Basic::ControllerMethods

    before_action :authenticate_user!

    private

    def authenticate_user!
      return if @current_user.present?

      authenticate_or_request_with_http_basic do |email, password|
        user = User.find_by_email(email)

        if user.valid_password?(password)
          @current_user = user
        else
          render json: {
            successful: false,
            error: 'Incorrect user or password.'
          }, status: :unauthorized
        end
      end
    end
  end
end
