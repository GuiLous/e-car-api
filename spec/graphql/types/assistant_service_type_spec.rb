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
end
