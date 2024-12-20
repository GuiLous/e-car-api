# frozen_string_literal: true

module Types
  class AssistantServiceFiltersType < Types::BaseInputObject
    argument :assistant_id, ID, required: false
    argument :modality, String, required: false
    argument :service_category_id, ID, required: false
    argument :status, String, required: false
  end
end
