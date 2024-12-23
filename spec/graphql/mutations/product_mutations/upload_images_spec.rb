# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::ProductMutations::UploadImages do
  describe '#resolve' do
    let(:mutation) do
      <<~GQL
        mutation(
          $productId: ID!,
          $images: [Upload!]!
        ) {
          uploadImages(productId: $productId, images: $images) {
            message
          }
        }
      GQL
    end

    it 'returns success with image upload' do
      image = fixture_file_upload(Rails.root.join("spec/fixtures/files/test_image.jpg"), 'image/jpeg')

      product = Fabricate :product

      variables = {
        images: [ image ],
        productId: product.id
      }

      response = EcarSchema.execute(mutation, variables: variables).as_json
      data = response['data']['uploadImages']

      expect(data['message']).to eq 'SUCCESS'
    end
  end
end
