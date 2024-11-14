# frozen_string_literal: true

module AuthServices
  class SignInService
    include Singleton

    def sign_in(email:, password:)
      puts "\n\n----------------------"
      puts email, password
      puts "\n\n----------------------"
      user = User.find_for_database_authentication(email: email)

      raise Exceptions::InvalidCredentialsError unless user&.valid_password?(password)

      puts "\n\n----------------------"
      puts "user 2222 #{user.inspect}"
      puts "\n\n----------------------"

      token = user.generate_jwt

      puts "\n\n----------------------"
      puts "token #{token}"
      puts "\n\n----------------------"

      { token: token }
    end
  end
end
