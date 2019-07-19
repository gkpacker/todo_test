# frozen_string_literal: true

require 'rails_helper'

shared_context 'api authentication', shared_context: :metadata do
  let!(:user) { FactoryBot.create(:user) }

  def basic_authentication_login(email = user.email, password = user.password)
    request.env['HTTP_AUTHORIZATION'] =
      ActionController::HttpAuthentication::Basic.encode_credentials(
        email,
        password
      )
  end
end
