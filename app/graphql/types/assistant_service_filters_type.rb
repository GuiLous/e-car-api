# frozen_string_literal: true

module Types
  class AssistantServiceFiltersType < Types::BaseInputObject
    argument :assistant_id, ID, required: false
    argument :modality, String, required: false
    argument :online, Boolean, required: false
    argument :service_category_id, ID, required: false
  end
end
