# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::AssistantServiceType do
  describe 'AssistantServiceType' do
    let(:query) do
      <<~GQL
        query {
          assistantServices {
            id
            price
            service {
              id
            }
            assistant {
              id
            }
          }
        }
      GQL
    end

    context 'when no assistant_id is provided' do
      context 'when the assistant service is active' do
        it 'returns the expected fields for a user' do
          assistant_service = Fabricate :assistant_service
          service = assistant_service.service
          assistant = assistant_service.assistant
          response = ProladdoreSchema.execute(query).as_json
          data = response['data']['assistantServices'][0]

          expect(data['id']).to eq(assistant_service.id.to_s)
          expect(data['price']).to eq(assistant_service.price)
          expect(data['assistant']['id']).to eq(assistant.id.to_s)
          expect(data['service']['id']).to eq(service.id.to_s)
        end
      end

      context 'when the assistant service is inactive' do
        it 'returns an empty array' do
          Fabricate :assistant_service, status: 'inactive'
          response = ProladdoreSchema.execute(query).as_json
          data = response['data']['assistantServices']

          expect(data.size).to eq(0)
        end
      end
    end

    context 'when an assistant_id is provided' do
      context 'when the assistant service is active' do
        it 'returns the expected fields for a user' do
          assistant_service = Fabricate :assistant_service
          service = assistant_service.service
          assistant = assistant_service.assistant

          filters = { assistant_id: assistant.id }
          response = ProladdoreSchema.execute(query, variables: { filters: filters }).as_json
          data = response['data']['assistantServices'][0]

          expect(data['id']).to eq(assistant_service.id.to_s)
          expect(data['price']).to eq(assistant_service.price)
          expect(data['assistant']['id']).to eq(assistant.id.to_s)
          expect(data['service']['id']).to eq(service.id.to_s)
        end
      end

      context 'when the assistant service is inactive' do
        it 'returns an empty array' do
          assistant_service = Fabricate :assistant_service, status: 'inactive'
          filters = { assistant_id: assistant_service.assistant.id }
          response = ProladdoreSchema.execute(query, variables: { filters: filters }).as_json
          data = response['data']['assistantServices']

          expect(data.size).to eq(0)
        end
      end
    end
  end
end
