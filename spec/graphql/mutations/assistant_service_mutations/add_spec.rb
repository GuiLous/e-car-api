# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::AssistantServiceMutations::Add do
  describe '#resolve' do
    let(:mutation) do
      <<~GQL
        mutation($modality: String!, $price: Int!, $serviceId: ID!, $serviceCategoryId: ID!) {
          addAssistantService(modality: $modality, price: $price, serviceId: $serviceId, serviceCategoryId: $serviceCategoryId) {
            message
          }
        }
      GQL
    end

    context 'when no error occurs' do
      it 'add assistant service' do
        service = Fabricate :service
        service_category = Fabricate :service_category
        assistant = Fabricate :assistant
        user = assistant.user

        variables = {
          modality: 'live',
          price: 100,
          serviceId: service.id,
          serviceCategoryId: service_category.id,
          description: 'description'
        }

        context = { current_user: user }

        response = ProladdoreSchema.execute(mutation, variables: variables, context: context).as_json

        data = response['data']['addAssistantService']['message']
        expect(data).to eq('SUCCESS')
      end
    end

    context 'when an error occurs' do
      context 'when a AssistantServiceAlreadyExistsError is raised' do
        it 'returns an AssistantServiceAlreadyExistsError error' do
          service = Fabricate :service
          service_category = Fabricate :service_category
          assistant = Fabricate :assistant
          user = assistant.user

          variables = {
            modality: 'live',
            price: 100,
            serviceId: service.id,
            serviceCategoryId: service_category.id
          }

          context = { current_user: user }

          ProladdoreSchema.execute(mutation, variables: variables, context: context).as_json
          response = ProladdoreSchema.execute(mutation, variables: variables, context: context).as_json
          error_message = response['errors'].first['message']
          expect(error_message).to eq('ASSISTANT_SERVICE_ALREADY_EXISTS')
        end
      end

      context 'when a StandardError is raised' do
        it 'returns a system error' do
          user = Fabricate :user

          allow(AssistantServiceServices::CreateService.instance).to receive(:create).and_raise(StandardError, 'SYSTEM_ERROR')

          variables = {
            modality: 'live',
            price: 100,
            serviceId: 9999,
            serviceCategoryId: 9999
          }

          context = { current_user: user }

          response = ProladdoreSchema.execute(mutation, variables: variables, context: context).as_json
          error_message = response['errors'].first['message']
          expect(error_message).to eq('SYSTEM_ERROR')
        end
      end
    end
  end
end
