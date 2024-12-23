# frozen_string_literal: true

module Types
  class ImageType < Types::BaseObject
    field :content_type, String, null: false
    field :filename, String, null: false
    field :url, String, null: false
  end
end
