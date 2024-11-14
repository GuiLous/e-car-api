# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::AssistantMutations::ChangeToAssistant do
  describe '#resolve' do
    let(:mutation) do
      <<~GQL
        mutation($userId: ID!, $nickname: String!, $description: String!, $modality: String!, $price: Int!, $serviceId: ID!) {
          changeToAssistant(userId: $userId, nickname: $nickname, description: $description, modality: $modality, price: $price, serviceId: $serviceId) {
            message
          }
        }
      GQL
    end

    context 'when no error occurs' do
      it 'change to assistant' do
        user = Fabricate :user, role: 1

        service = Fabricate :service

        variables = {
          userId: user.id,
          nickname: 'xpto',
          description: 'xpto',
          modality: 'live',
          price: 100,
          serviceId: service.id
        }

        response = ProladdoreSchema.execute(mutation, variables: variables).as_json

        data = response['data']['changeToAssistant']['message']
        expect(data).to eq('SUCCESS')
      end
    end

    context 'when a StandardError is raised' do
      it 'returns a system error' do
        allow(AssistantServices::ChangeToAssistantService.instance).to receive(:change_to_assistant).and_raise(StandardError, 'SYSTEM_ERROR')

        variables = {
          userId: 9999,
          nickname: 'xpto',
          description: 'xpto',
          modality: 'live',
          price: 100,
          serviceId: 9999
        }

        response = ProladdoreSchema.execute(mutation, variables: variables).as_json
        error_message = response['errors'].first['message']
        expect(error_message).to eq('SYSTEM_ERROR')
      end
    end
  end
end
