# frozen_string_literal: true

module AuthServices
  class SignInService
    include Singleton

    def sign_in(email:, password:)
      user = User.find_for_database_authentication(email: email)

      raise Exceptions::InvalidCredentialsError unless user&.valid_password?(password)

      token = user.generate_jwt

      { user: user, token: token }
    end
  end
end
