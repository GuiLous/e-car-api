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
            visible
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
      context 'when the assistant service is visible' do
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

      context 'when the assistant service is hidden' do
        it 'returns an empty array' do
          Fabricate :assistant_service, visible: 'hidden'
          response = ProladdoreSchema.execute(query).as_json
          data = response['data']['assistantServices']

          expect(data.size).to eq(0)
        end
      end
    end

    context 'when a assistant_id is provided' do
      context 'when the assistant service is visible' do
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

      context 'when the assistant service is hidden' do
        it 'returns an empty array' do
          assistant_service = Fabricate :assistant_service, visible: 'hidden'
          filters = { assistant_id: assistant_service.assistant.id }
          response = ProladdoreSchema.execute(query, variables: { filters: filters }).as_json
          data = response['data']['assistantServices']

          expect(data.size).to eq(0)
        end
      end
    end

    context 'when visible is true' do
      it 'returns the expected fields for a user' do
        Fabricate :assistant_service, visible: 'visible'
        response = ProladdoreSchema.execute(query).as_json
        data = response['data']['assistantServices'][0]

        expect(data['visible']).to be(true)
      end
    end
  end
end
