# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AssistantServices::ChangeToAssistantService do
  describe '#change_to_assistant' do
    context "when user is not an assistant" do
      it 'create assistant model' do
        user = Fabricate(:user)
        service = Fabricate(:service)
        service_category = Fabricate(:service_category)

        context = { current_user: user }

        described_class.instance.change_to_assistant(
          description: 'xpto',
          modality: 'live',
          price: 100,
          service_id: service.id,
          service_category_id: service_category.id,
          context: context
        )

        assistant = user.assistant.reload

        expect(assistant.description).to eq('xpto')
        expect(assistant.assistant_services.first.modality).to eq('live')
        expect(assistant.assistant_services.first.price).to eq(100)
        expect(assistant.assistant_services.first.service_id).to eq(service.id)
        expect(assistant.assistant_services.first.service_category_id).to eq(service_category.id)
      end
    end

    context "when user is an assistant" do
      it 'raise error' do
        assistant = Fabricate(:assistant)

        user = assistant.user

        service = Fabricate(:service)
        service_category = Fabricate(:service_category)

        context = { current_user: user }

        expect do
          described_class.instance.change_to_assistant(
            description: 'xpto',
            modality: 'live',
            price: 100,
            service_id: service.id,
            service_category_id: service_category.id,
            context: context
          )
        end.to raise_error(Exceptions::UserIsAlreadyAnAssistantError)
      end
    end
  end
end
