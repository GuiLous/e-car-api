# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::AssistantServiceMutations::UpdateVisibility do
  describe '#resolve' do
    let(:mutation) do
      <<~GQL
        mutation($assistantServiceId: ID!, $visible: String!) {
          updateVisibility(assistantServiceId: $assistantServiceId, visible: $visible) {
            message
          }
        }
      GQL
    end

    context 'when no error occurs' do
      it 'updates visibility of an assistant service' do
        assistant_service = Fabricate :assistant_service

        variables = {
          assistantServiceId: assistant_service.id,
          visible: 'visible'
        }

        context = { current_user: assistant_service.assistant.user }

        response = ProladdoreSchema.execute(mutation, variables: variables, context: context).as_json

        data = response['data']['updateVisibility']['message']
        expect(data).to eq('SUCCESS')
      end
    end

    context 'when an error occurs' do
      context 'when a StandardError is raised' do
        it 'returns a system error' do
          assistant_service = Fabricate :assistant_service

          allow(AssistantServiceServices::UpdateVisibilityService.instance).to receive(:update_visibility).and_raise(StandardError, 'SYSTEM_ERROR')

          variables = {
            assistantServiceId: assistant_service.id,
            visible: 'visible'
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
