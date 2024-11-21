# frozen_string_literal: true

module UserServices
  class CreateService
    include Singleton

    def create(params)
      User.create!(params).tap do |user|
        Wallet.create(user: user) if user.persisted?
      end
    end
  end
end
