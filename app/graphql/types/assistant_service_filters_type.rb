# frozen_string_literal: true

module Types
  class AssistantServiceFiltersType < Types::BaseInputObject
    argument :assistant_id, ID, required: false
  end
end
