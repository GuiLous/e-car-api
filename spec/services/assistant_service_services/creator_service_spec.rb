# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AssistantServiceServices::CreatorService do
  describe '#creator' do
    context 'when no error occurs' do
      it 'creates an assistant service' do
        service = Fabricate :service
        service_category = Fabricate :service_category
        assistant = Fabricate :assistant
        user = assistant.user

        described_class.instance.creator(
          modality: 'live',
          price: 100,
          service_id: service.id,
          service_category_id: service_category.id,
          context: { current_user: user }
        )

        expect(AssistantService.count).to eq(1)
      end
    end

    context 'when an error occurs' do
      context 'when a AssistantServiceAlreadyExistsError is raised' do
        it 'raises an error' do
          service = Fabricate :service
          service_category = Fabricate :service_category
          assistant = Fabricate :assistant
          user = assistant.user

          described_class.instance.creator(
            modality: 'live',
            price: 100,
            service_id: service.id,
            service_category_id: service_category.id,
            context: { current_user: user }
          )

          expect do
            described_class.instance.creator(
              modality: 'live',
              price: 100,
              service_id: service.id,
              service_category_id: service_category.id,
              context: { current_user: user }
            )
          end.to raise_error(Exceptions::AssistantServiceAlreadyExistsError)
        end
      end
    end
  end
end
