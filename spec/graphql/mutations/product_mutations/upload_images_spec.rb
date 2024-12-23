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
      user = Fabricate :user
      product = Fabricate :product

      file = ApolloUploadServer::Wrappers::UploadedFile.new(Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/test_image.jpg'), 'image/jpg'))

      variables = {
        images: [ file ],
        productId: product.id
      }

      context = { current_user: user }

      response = EcarSchema.execute(mutation, variables: variables, context: context).as_json
      data = response['data']['uploadImages']

      expect(data['message']).to eq 'SUCCESS'
    end
  end
end
