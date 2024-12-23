# frozen_string_literal: true

module Mutations
  module ProductMutations
    class UploadImages < BaseMutation
      include ::Authenticatable

      argument :images, [ ApolloUploadServer::Upload ], required: true
      argument :product_id, ID, required: true

      field :message, String, null: true

      def resolve(images:, product_id:)
        authenticate_user!

        ProductServices::UploadImagesService.instance.upload(
          images: images,
          product_id: product_id
        )
      rescue Exceptions::ProductNotFound, Exceptions::ImageRequired, Exceptions::UnauthorizedError => e
        raise GraphQL::ExecutionError, e.message
      rescue StandardError
        raise GraphQL::ExecutionError, "SYSTEM_ERROR"
      end
    end
  end
end
