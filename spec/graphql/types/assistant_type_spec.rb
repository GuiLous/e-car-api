# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::AssistantType do
  describe 'AssistantType' do
    let(:query) do
      <<~GQL
        query {
          me {
            assistant {
              description
              id
              user {
                id
              }
              hiredServices {
                id
              }
            }
          }
        }
      GQL
    end

    it 'returns the expected fields for a user' do
      assistant = Fabricate :assistant
      user = assistant.user
      assistant_service = Fabricate :assistant_service, assistant: assistant
      Fabricate :hired_service, assistant_service: assistant_service

      context = { current_user: user }
      response = ProladdoreSchema.execute(query, context: context).as_json

      data = response['data']['me']['assistant']

      expect(data['id']).to eq(assistant.id.to_s)
      expect(data['description']).to eq(assistant.description)
      expect(data['user']['id']).to eq(user.id.to_s)
      expect(data['hiredServices'].size).to eq(1)
    end
  end
end
