# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::AssistantMutations::ChangeToAssistant do
  describe '#resolve' do
    let(:mutation) do
      <<~GQL
        mutation($nickname: String!, $description: String!, $modality: String!, $price: Int!, $serviceId: ID!, $serviceCategoryId: ID!) {
          changeToAssistant(nickname: $nickname, description: $description, modality: $modality, price: $price, serviceId: $serviceId, serviceCategoryId: $serviceCategoryId) {
            message
          }
        }
      GQL
    end

    context 'when no error occurs' do
      it 'change to assistant' do
        user = Fabricate :user, role: 1
        service = Fabricate :service
        service_category = Fabricate :service_category

        variables = {
          nickname: 'xpto',
          description: 'xpto',
          modality: 'live',
          price: 100,
          serviceId: service.id,
          serviceCategoryId: service_category.id
        }

        context = { current_user: user }

        response = ProladdoreSchema.execute(mutation, variables: variables, context: context).as_json
        data = response['data']['changeToAssistant']['message']
        expect(data).to eq('SUCCESS')
      end
    end

    context 'when an error occurs' do
      context 'when a StandardError is raised' do
        it 'returns a system error' do
          user = Fabricate :user

          allow(AssistantServices::ChangeToAssistantService.instance).to receive(:change_to_assistant).and_raise(StandardError, 'SYSTEM_ERROR')

          variables = {
            nickname: 'xpto',
            description: 'xpto',
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

      context 'when a UserIsAlreadyAnAssistantError is raised' do
        it 'returns a system error' do
          assistant = Fabricate :assistant
          user = assistant.user

          service = Fabricate :service
          service_category = Fabricate :service_category

          variables = {
            nickname: 'xpto',
            description: 'xpto',
            modality: 'live',
            price: 100,
            serviceId: service.id,
            serviceCategoryId: service_category.id
          }

          context = { current_user: user }

          response = ProladdoreSchema.execute(mutation, variables: variables, context: context).as_json

          error_message = response['errors'].first['message']
          expect(error_message).to eq('USER_ALREADY_AN_ASSISTANT')
        end
      end
    end
  end
end
