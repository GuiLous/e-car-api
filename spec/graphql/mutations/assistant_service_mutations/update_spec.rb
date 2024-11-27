# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::AssistantServiceMutations::Update do
  describe '#resolve' do
    let(:mutation) do
      <<~GQL
        mutation($assistantServiceAttributes: AssistantServiceInput!, $assistantServiceId: ID!) {
          updateAssistantService(assistantServiceId: $assistantServiceId, assistantServiceAttributes: $assistantServiceAttributes) {
            message
          }
        }
      GQL
    end

    context 'when no error occurs' do
      it 'updates an assistant service' do
        assistant_service = Fabricate :assistant_service, description: 'current description'
        service = Fabricate :service
        service_category = Fabricate :service_category

        attributes = {
          modality: 'live',
          price: 100,
          serviceId: service.id,
          serviceCategoryId: service_category.id,
          description: 'new description'
        }

        variables = {
          assistantServiceAttributes: attributes,
          assistantServiceId: assistant_service.id
        }
        context = { current_user: assistant_service.assistant.user }

        response = ProladdoreSchema.execute(mutation, variables: variables, context: context).as_json

        data = response.dig('data', 'updateAssistantService', 'message')
        expect(data).to eq('SUCCESS')

        assistant_service.reload

        expect(assistant_service).to have_attributes(
          modality: 'live',
          price: 100,
          service_id: service.id,
          service_category_id: service_category.id,
          description: 'new description'
        )
      end
    end

    context 'when an error occurs' do
      context 'when a StandardError is raised' do
        it 'returns a system error' do
          assistant_service = Fabricate :assistant_service
          service = Fabricate :service
          service_category = Fabricate :service_category

          allow(AssistantServiceServices::UpdateService.instance).to receive(:update).and_raise(StandardError, 'SYSTEM_ERROR')

          attributes = {
            modality: 'live',
            price: 100,
            serviceId: service.id,
            serviceCategoryId: service_category.id,
            description: 'description'
          }

          variables = {
            assistantServiceAttributes: attributes,
            assistantServiceId: assistant_service.id
          }
          context = { current_user: assistant_service.assistant.user }

          response = ProladdoreSchema.execute(mutation, variables: variables, context: context).as_json
          error_message = response['errors'].first['message']
          expect(error_message).to eq('SYSTEM_ERROR')
        end
      end
    end
  end
end
