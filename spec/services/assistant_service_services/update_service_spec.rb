# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AssistantServiceServices::UpdateService do
  describe '#update' do
    it 'updates the assistant service with the given attributes' do
      assistant_service = Fabricate :assistant_service
      service = Fabricate :service
      service_category = Fabricate :service_category

      attributes = {
        modality: 'live',
        price: 100,
        service_id: service.id,
        service_category_id: service_category.id,
        description: 'description'
      }

      described_class.instance.update(
        assistant_service_id: assistant_service.id,
        attributes: attributes
      )

      expect(assistant_service.reload).to have_attributes(attributes)
    end
  end
end
