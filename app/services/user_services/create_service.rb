# frozen_string_literal: true

module UserServices
  class CreateService
    include Singleton

    def create(params)
      User.create!(params)
    end
  end
end
