# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::HiredServiceType do
  describe 'AssistantType' do
    let(:query) do
      <<~GQL
        query {
          me {
            assistant {
              hiredServices {
                analysisStartedAt
                id
                scheduleDate
                status
                assistantService {
                  id
                }
                user {
                  id
                }
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
      hired_service = Fabricate :hired_service, assistant_service: assistant_service
      allow(ENV).to receive(:fetch).with('LOGGED_USER_ID').and_return(user.id.to_s)

      context = { current_user: user }

      response = ProladdoreSchema.execute(query, context: context).as_json
      data = response['data']['me']['assistant']['hiredServices'][0]

      expect(data['id']).to eq(hired_service.id.to_s)
      expect(data['analysisStartedAt']).to eq(hired_service.analysis_started_at)
      expect(data['scheduleDate']).to eq(hired_service.schedule_date.to_s)
      expect(data['status']).to eq(hired_service.status)
      expect(data['assistantService']['id']).to eq(hired_service.assistant_service.id.to_s)
      expect(data['user']['id']).to eq(hired_service.user.id.to_s)
    end
  end
end
