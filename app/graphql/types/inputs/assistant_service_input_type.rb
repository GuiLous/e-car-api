# frozen_string_literal: true

module Types
  module Inputs
    class AssistantServiceInputType < GraphQL::Schema::InputObject
      argument :deadline, String
      argument :description, String, required: true
      argument :modality, String, required: true
      argument :price, Integer, required: true
      argument :service_category_id, ID, required: true
      argument :title, String, required: true
    end
  end
end
