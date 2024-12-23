# frozen_string_literal: true

module ProductServices
  class CreateService
    include Singleton

    def create(params)
      Product.create!(params)
      { message: "SUCCESS" }
    end
  end
end
