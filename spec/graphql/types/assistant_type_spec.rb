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
              nickname
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
      allow(ENV).to receive(:fetch).with('LOGGED_USER_ID').and_return(user.id.to_s)

      response = ProladdoreSchema.execute(query).as_json

      data = response['data']['me']['assistant']

      expect(data['id']).to eq(assistant.id.to_s)
      expect(data['description']).to eq(assistant.description)
      expect(data['nickname']).to eq(assistant.nickname)
      expect(data['user']['id']).to eq(user.id.to_s)
      expect(data['hiredServices'].size).to eq(1)
    end
  end
end
