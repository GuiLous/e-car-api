# frozen_string_literal: true

module ProductServices
  class UploadImagesService
    include Singleton

    def upload(product_id:, images:)
      product = Product.find(product_id)

      raise Exceptions::ProductNotFound if product.blank?
      raise Exceptions::ImageRequired if images.blank?

      delete_product_images_from_cdn(product)

      images.each do |image|
        product.images.attach(io: image.tempfile, filename: image.original_filename, content_type: image.content_type)
      end

      { message: "SUCCESS" }
    end

    private

    def delete_product_images_from_cdn(product)
      product.images.each do |image|
        public_id = image.blob.key

        Cloudinary::Uploader.destroy(public_id)

        image.purge
      end
    end
  end
end
