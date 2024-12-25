# frozen_string_literal: true

require "rails_helper"

RSpec.describe ProductServices::UploadImagesService do
  describe '#upload' do
    it 'upload images' do
      allow(Cloudinary::Uploader).to receive(:destroy).and_return(true)

      product = Fabricate(:product)
      user = product.user

      file = ApolloUploadServer::Wrappers::UploadedFile.new(Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/test_image.jpg'), 'image/jpg'))

      product.images.attach(io: Rails.root.join('spec/fixtures/files/test_image.jpg').open, filename: 'test_image.jpg', content_type: 'image/jpg')

      result = described_class.instance.upload(
        product_id: product.id,
        images: [ file ],
        user: user
      )

      expect(result[:message]).to be 'SUCCESS'
    end
  end
end
