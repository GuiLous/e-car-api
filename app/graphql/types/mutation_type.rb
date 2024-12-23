# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    # Auth
    field :sign_in, mutation: Mutations::AuthMutations::SignIn

    # User
    field :sign_up, mutation: Mutations::UserMutations::SignUp

    # Product
    field :create_product, mutation: Mutations::ProductMutations::Create
    field :upload_images, mutation: Mutations::ProductMutations::UploadImages
  end
end
