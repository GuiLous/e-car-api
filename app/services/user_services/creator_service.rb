# frozen_string_literal: true

module UserServices
  class CreatorService
    include Singleton

    def create(email:, name:, password:)
      user = ::User.new(email: email, name: name, password: password)

      raise ActiveRecord::RecordInvalid unless user.save

      Wallet.create(user: user)
      user
    end
  end
end
