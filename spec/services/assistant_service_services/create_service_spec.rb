# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AssistantServiceServices::CreateService do
  describe '#create' do
    context 'when no error occurs' do
      it 'creates an assistant service without a service' do
        service_category = Fabricate :service_category
        assistant = Fabricate :assistant
        user = assistant.user

        result = described_class.instance.create(
          modality: 'live',
          price: 100,
          service_category_id: service_category.id,
          context: { current_user: user }
        )

        expect(AssistantService.count).to eq(1)
        expect(result.service).to be_nil
      end
    end

    context 'when an error occurs' do
      context 'when a AssistantServiceAlreadyExistsError is raised' do
        it 'raises an error' do
          service_category = Fabricate :service_category
          assistant = Fabricate :assistant
          user = assistant.user

          described_class.instance.create(
            modality: 'live',
            price: 100,
            service_category_id: service_category.id,
            context: { current_user: user }
          )

          expect do
            described_class.instance.create(
              modality: 'live',
              price: 100,
              service_category_id: service_category.id,
              context: { current_user: user }
            )
          end.to raise_error(Exceptions::AssistantServiceAlreadyExistsError)
        end
      end
    end
  end
end
