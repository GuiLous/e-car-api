# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::AssistantMutations::SubmitAssistant do
  describe '#resolve' do
    let(:mutation) do
      <<~GQL
        mutation($description: String!, $modality: String!, $price: Int!, $serviceCategoryId: ID!, $title: String!) {
          submitAssistant(description: $description, modality: $modality, price: $price, serviceCategoryId: $serviceCategoryId, title: $title) {
            message
          }
        }
      GQL
    end

    context 'when no error occurs' do
      it 'change to assistant' do
        user = Fabricate :user, role: 1
        service_category = Fabricate :service_category

        variables = {
          title: 'I am an assistant',
          description: 'xpto',
          modality: 'live',
          price: 100,
          serviceCategoryId: service_category.id
        }

        context = { current_user: user }

        response = ProladdoreSchema.execute(mutation, variables: variables, context: context).as_json
        data = response['data']['submitAssistant']['message']
        expect(data).to eq('SUCCESS')
      end
    end

    context 'when an error occurs' do
      context 'when a StandardError is raised' do
        it 'returns a system error' do
          user = Fabricate :user

          allow(AssistantSubmissionServices::CreateService.instance).to receive(:create).and_raise(StandardError, 'SYSTEM_ERROR')

          variables = {
            title: 'I am an assistant',
            description: 'xpto',
            modality: 'live',
            price: 100,
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

          service_category = Fabricate :service_category

          variables = {
            title: 'I am an assistant',
            description: 'xpto',
            modality: 'live',
            price: 100,
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
