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

    context "when no errors occurs" do
      it 'returns success with image upload' do
        product = Fabricate :product
        user = product.user

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

    context "when errors occurs" do
      context "when product is not found" do
        it 'raise ProductNotFound' do
          allow(Product).to receive(:find).and_return(nil)

          product = Fabricate :product
          user = product.user

          file = ApolloUploadServer::Wrappers::UploadedFile.new(Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/test_image.jpg'), 'image/jpg'))

          variables = {
            images: [ file ],
            productId: product.id
          }

          context = { current_user: user }

          response = EcarSchema.execute(mutation, variables: variables, context: context).as_json
          data = response['errors'][0]

          expect(data['message']).to eq 'PRODUCT_NOT_FOUND'
        end
      end

      context "when user is not owner" do
        it 'raise ProductNotFound' do
          product = Fabricate :product
          user = Fabricate :user

          file = ApolloUploadServer::Wrappers::UploadedFile.new(Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/test_image.jpg'), 'image/jpg'))

          variables = {
            images: [ file ],
            productId: product.id
          }

          context = { current_user: user }

          response = EcarSchema.execute(mutation, variables: variables, context: context).as_json
          data = response['errors'][0]

          expect(data['message']).to eq 'USER_IS_NOT_OWNER'
        end
      end

      context "when no image is sent" do
        it 'raise IMAGE_REQUIRED' do
          product = Fabricate :product
          user = product.user

          variables = {
            images: [],
            productId: product.id
          }

          context = { current_user: user }

          response = EcarSchema.execute(mutation, variables: variables, context: context).as_json
          data = response['errors'][0]

          expect(data['message']).to eq 'IMAGE_REQUIRED'
        end
      end

      context "when user is not authenticated" do
        it 'raise UNAUTHORIZED' do
          product = Fabricate :product

          file = ApolloUploadServer::Wrappers::UploadedFile.new(Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/test_image.jpg'), 'image/jpg'))

          variables = {
            images: [ file ],
            productId: product.id
          }

          response = EcarSchema.execute(mutation, variables: variables).as_json
          data = response['errors'][0]

          expect(data['message']).to eq 'UNAUTHORIZED'
        end
      end

      context "when an StandardError occurs" do
        it 'raise SYSTEM_ERROR' do
          allow(ProductServices::UploadImagesService.instance).to receive(:upload).and_raise(StandardError, 'SYSTEM_ERROR')

          product = Fabricate :product
          user = product.user

          file = ApolloUploadServer::Wrappers::UploadedFile.new(Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/test_image.jpg'), 'image/jpg'))

          variables = {
            images: [ file ],
            productId: product.id
          }

          context = { current_user: user }

          response = EcarSchema.execute(mutation, variables: variables, context: context).as_json
          data = response['errors'][0]

          expect(data['message']).to eq 'SYSTEM_ERROR'
        end
      end
    end
  end
end
